class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts do |t|
      t.date :issue_date
      t.integer :hours
      t.integer :total_cost
      t.integer :client_id
      t.integer :service_id

      t.timestamps
    end
  end
end
