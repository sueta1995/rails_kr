class AddFirstNameToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :first_name, :string, length:23
  end
end
