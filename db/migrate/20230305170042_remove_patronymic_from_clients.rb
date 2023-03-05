class RemovePatronymicFromClients < ActiveRecord::Migration[7.0]
  def change
    remove_column :clients, :patronymic, :text
  end
end
