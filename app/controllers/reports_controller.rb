class ReportsController < ApplicationController
  before_action :check_current_user, only: %i[index]
  before_action :set_params, only: %i[create]

  include ReportsHelper

  def index
    # @query = ActiveRecord::Base.connection.execute('select * from clients').to_a  
    @@query_types = {
      'first_sql' => 1,
      'second_sql' => 2,
      'third_sql' => 3,
      'fourth_sql' => 4,
      'fifth_sql' => 5
    }
  end

  def create
    @query = @@query_types[@query_params]
  end
end
