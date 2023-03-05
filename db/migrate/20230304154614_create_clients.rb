class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.text :first_name
      t.text :surname
      t.text :patronymic
      t.integer :phone
      t.integer :passport_series
      t.integer :passport_number
      t.date :birthday

      t.timestamps
    end
  end
end
