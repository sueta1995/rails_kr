module ReportsHelper
  def check_current_user
    redirect_to '/session/new' if current_user.nil?
  end
end
