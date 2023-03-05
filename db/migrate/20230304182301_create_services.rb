class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.integer :price_per_hour
      t.text :description

      t.timestamps
    end
  end
end
