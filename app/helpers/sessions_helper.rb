# frozen_string_literal: true

# модуль для контроллера сессий
module SessionsHelper
  def set_params
    @user_params = params.require(:session)
  end

  def set_info
    session[:username] = @user_params[:username]
  end

  def connnect_database
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: 'localhost',
      port: '5432',
      username: @user_params[:username],
      password: @user_params[:password],
      database: 'speech_therapist_service'
    )
  end

  def check_current_user
    redirect_to root_path, notice: 'Вы уже вошли в аккаунт!' if current_user.present?
  end
end
