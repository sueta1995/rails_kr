class AddPatronymicToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :patronymic, :string, length:23
  end
end
