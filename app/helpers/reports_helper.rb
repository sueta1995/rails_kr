module ReportsHelper
  def check_current_user
    redirect_to '/session/new' if current_user.nil?
  end

  def set_params
    @query_params = params[:report]
  end

  def first_sql
    "SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone
    FROM clients c 
    WHERE c.id NOT IN ( 
      SELECT st.client_id FROM speech_therapists st 
    ) 
    AND c.id NOT IN ( 
      SELECT con.client_id 
      FROM contracts con 
    )"
  end

  def second_sql
    "WITH st_query AS (
      SELECT st.client_id
      FROM speech_therapists st
      WHERE st.id NOT IN (
        SELECT s.speech_therapist_id
        FROM services s
      )
    )
    
    SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone
    FROM clients c
    WHERE c.id IN (
      SELECT client_id
      FROM st_query
    )"
  end

  def third_sql
    "WITH s_count AS (
      SELECT st.id, count(s.speech_therapist_id)
      FROM speech_therapists st, services s
      WHERE st.id = s.speech_therapist_id
      GROUP BY st.id
    ),
    
    st_rate AS (
      SELECT r.speech_therapist_id, ROUND(AVG(r.count), 2)
      FROM rates r
      GROUP BY r.speech_therapist_id
    )
    
    SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone, str.round
    FROM clients c, speech_therapists st
    JOIN st_rate str ON st.id = str.speech_therapist_id
    WHERE c.id = st.client_id
    AND st.id IN (
      SELECT MAX(count)
      FROM s_count
      GROUP BY id
    )"
  end

  def fourth_sql
    "WITH con_services AS (
      SELECT con.service_id, COUNT(con.id)
      FROM contracts con
      GROUP BY con.service_id
    ),
    
    st_count AS (
      SELECT s.speech_therapist_id, SUM(cs.count)
      FROM con_services cs
      JOIN services s ON cs.service_id = s.id
      GROUP BY s.speech_therapist_id
    ),
    
    st_max AS (
      SELECT stc.speech_therapist_id, stc.sum
      FROM st_count stc
      WHERE stc.sum = (
        SELECT MAX(sum)
        FROM st_count
      )
    )
    
    SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone, stm.sum
    FROM st_max stm
    JOIN speech_therapists st ON st.id = stm.speech_therapist_id
    JOIN clients c ON c.id = st.client_id"
  end

  def fifth_sql
    "WITH con_clients AS (
      SELECT con.client_id, SUM(con.id)
      FROM contracts con
      GROUP BY con.client_id
    ),
    
    con_max AS (
      SELECT MAX(conc.sum)
      FROM con_clients conc
    ),
    
    c_all AS (
      SELECT conc.client_id, conc.sum
      FROM con_clients conc, con_max conm
      WHERE conc.sum = conm.max
    )
    
    SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone, ca.sum
    FROM clients c
    JOIN c_all ca ON c.id = ca.client_id
    WHERE c.id IN (
      SELECT client_id
      FROM c_all
    )"
  end
end
