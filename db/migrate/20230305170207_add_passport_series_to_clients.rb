class AddPassportSeriesToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :passport_series, :string, length:4
  end
end
