class RemovePhoneFromClients < ActiveRecord::Migration[7.0]
  def change
    remove_column :clients, :phone, :integer
  end
end
