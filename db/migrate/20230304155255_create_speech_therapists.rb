class CreateSpeechTherapists < ActiveRecord::Migration[7.0]
  def change
    create_table :speech_therapists do |t|
      t.integer :client_id

      t.timestamps
    end
  end
end
