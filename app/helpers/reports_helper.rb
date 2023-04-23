# frozen_string_literal: true

# модуль для контроллера отчетов
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
    "WITH com_speech_therapists AS (
      SELECT com.speech_therapist_id, AVG(com.rate_value)
      FROM comments com
      GROUP BY com.speech_therapist_id
    ),
    
    st_max AS (
      SELECT cst.speech_therapist_id, cst.avg
      FROM com_speech_therapists cst
      WHERE cst.avg = (
        SELECT MAX(avg)
        FROM com_speech_therapists
      )
    )
    
    SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone, ROUND(stm.avg, 2)
    FROM st_max stm
    JOIN speech_therapists st ON st.id = stm.speech_therapist_id
    JOIN clients c ON c.id = st.client_id"
  end

  def third_sql
    "WITH con_services AS (
      SELECT con.service_id, COUNT(con.id)
      FROM contracts con
      GROUP BY con.service_id
    ),
    
    ser_types AS (
      SELECT t.name, cs.count
      FROM con_services cs
      JOIN services s ON s.id = cs.service_id
      JOIN types t ON t.id = s.type_id
    ),
    
    max_types AS (
      SELECT st.name, sum(st.count)
      FROM ser_types st
      GROUP BY st.name
      ORDER BY sum(st.count) DESC
    )
    
    SELECT *
    FROM max_types"
  end

  def fourth_sql
    "WITH con_speech_therapists AS (
      SELECT con.speech_therapist_id, COUNT(con.id)
      FROM contracts con
      GROUP BY con.speech_therapist_id
    ),
    
    st_max AS (
      SELECT cst.speech_therapist_id, cst.count
      FROM con_speech_therapists cst
      WHERE cst.count = (
        SELECT MAX(count)
        FROM con_speech_therapists
      )
    )
    
    SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone, stm.count
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

  def sixth_sql
    "SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone
    FROM clients c
    WHERE c.id IN (
      SELECT client_id
      FROM banned_clients
    )
    AND c.id IN (
      SELECT client_id
      FROM speech_therapists
    )"
  end

  def seventh_sql
    "SELECT c.surname, c.first_name, c.patronymic, c.birthday, c.phone
    FROM clients c
    WHERE c.id IN (
      SELECT client_id
      FROM speech_therapists
    )
    AND c.birthday <= '2005-12-31'
    AND c.birthday >= '2005-01-01'"
  end
end
