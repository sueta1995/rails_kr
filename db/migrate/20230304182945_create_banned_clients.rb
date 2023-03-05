class CreateBannedClients < ActiveRecord::Migration[7.0]
  def change
    create_table :banned_clients do |t|
      t.integer :client_id
      t.text :reason

      t.timestamps
    end
  end
end
