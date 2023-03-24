class ReportsController < ApplicationController
  before_action :check_current_user, only: %i[index]
  before_action :set_params, only: %i[create]

  include ReportsHelper

  def index
    # @query = ActiveRecord::Base.connection.execute('select * from clients').to_a  
    @@query_types = {
      'first_sql' => first_sql,
      'second_sql' => second_sql,
      'third_sql' => third_sql,
      'fourth_sql' => fourth_sql,
      'fifth_sql' => fifth_sql
    }
  end

  def create
    query = @@query_types[@query_params]

    if query.present?
      @results = ActiveRecord::Base.connection.execute(query).to_a
      @count = @results.count
      @keys = @results[0].keys if @count.nonzero?
    else
      redirect_to root_path, alert: 'Выберите правильный запрос!'
    end
  end
end
