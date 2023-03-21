module ReportsHelper
  def check_current_user
    redirect_to '/session/new' if current_user.nil?
  end

  def set_params
    @query_params = params[:report]
  end

  def first_sql
    "SELECT c.surname, c.first_name, c.patronymic, c.phone, c.birthday\n" \
    "FROM clients c\n" \
    "WHERE c.id NOT IN (\n" \
    "\tSELECT st.client_id\n" \
    "\tFROM speech_therapists st\n" \
    ")\n" \
    "AND c.id NOT IN (\n" \
    "\tSELECT con.client_id\n" \
    "\tFROM contracts con\n" \
    ")"
  end
end
