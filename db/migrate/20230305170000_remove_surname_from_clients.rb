class RemoveSurnameFromClients < ActiveRecord::Migration[7.0]
  def change
    remove_column :clients, :surname, :text
  end
end
