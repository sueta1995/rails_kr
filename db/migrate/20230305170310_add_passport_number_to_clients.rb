class AddPassportNumberToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :passport_number, :string, length:6
  end
end
