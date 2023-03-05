# frozen_string_literal: true

class Rate < ApplicationRecord
  belongs_to :client
  belongs_to :speech_therapist

  validates :count, presence: { message: 'Оценка не может быть пустой' }
  validates :speech_therapist_id, presence: { message: 'Идентификатор логопеда не может быть пустым' }
  validates :client_id, presence: { message: 'Идентификатор пользователя не может быть пустым' }
end
