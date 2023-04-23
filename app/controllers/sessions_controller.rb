# frozen_string_literal: true

# класс контроллера для работы с сессиями
class SessionsController < ApplicationController
  before_action :set_params, only: %i[create]
  before_action :connnect_database, only: %i[create]
  before_action :check_current_user, only: %i[new]

  include SessionsHelper

  def new; end

  def create
    ActiveRecord::Base.connection.instance_eval { @config[:database] }.nil?

    set_info

    redirect_to root_path, notice: 'Вы успешно зашли в аккаунт!'
  rescue StandardError
    flash.now[:alert] = 'Неправильные данные аккаунта!'

    render :new
  end

  def destroy
    session.delete(:username)
    ActiveRecord::Base.connection.close

    redirect_to root_path, notice: 'Вы вышли из аккаунта!'
  end
end
