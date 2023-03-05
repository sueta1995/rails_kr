class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.integer :count
      t.integer :speech_therapist_id
      t.integer :client_id

      t.timestamps
    end
  end
end
