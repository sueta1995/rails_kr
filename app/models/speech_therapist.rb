# frozen_string_literal: true

class SpeechTherapist < ApplicationRecord
  belongs_to :client

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  validates :client_id, presence: { message: 'Идентификатор пользователя не может быть пустым' }

  validates :client_id, uniqueness: { message: 'Данный пользователь уже является логопедом' }
end
