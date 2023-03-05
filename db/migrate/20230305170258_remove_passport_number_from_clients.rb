class RemovePassportNumberFromClients < ActiveRecord::Migration[7.0]
  def change
    remove_column :clients, :passport_number, :integer
  end
end
