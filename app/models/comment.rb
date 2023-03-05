# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :client
  belongs_to :speech_therapist

  validates :client_id, presence: { message: 'Идентификатор не может быть пустым' }
  validates :speech_therapist_id, presence: { message: 'Идентификатор логопеда не может быть пустым' }
  validates :body, presence: { message: 'Тело комментария не может быть пустым' }
end
