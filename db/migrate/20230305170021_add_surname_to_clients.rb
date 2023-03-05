class AddSurnameToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :surname, :string, length:23
  end
end
