class RemovePassportSeriesFromClients < ActiveRecord::Migration[7.0]
  def change
    remove_column :clients, :passport_series, :integer
  end
end
