class RemoveFirstNameFromClients < ActiveRecord::Migration[7.0]
  def change
    remove_column :clients, :first_name, :text
  end
end
