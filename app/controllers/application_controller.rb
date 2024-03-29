# frozen_string_literal: true

# класс контроллера приложения
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= session[:username] if session[:username]
  end
end
