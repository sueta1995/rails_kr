class ReportsController < ApplicationController
  before_action :check_current_user, only: %i[index]

  include ReportsHelper

  def index
    @query = ActiveRecord::Base.connection.execute('select * from clients').to_a  
  end
end
