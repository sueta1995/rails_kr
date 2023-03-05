class AddSpeechTherapistIdToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :speech_therapist_id, :integer
  end
end
