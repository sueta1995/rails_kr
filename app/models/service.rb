# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :speech_therapist

  has_many :contracts, dependent: :destroy

  validates :price_per_hour, presence: { message: 'Цена не может быть пустой' }

  validates :description, format: {
    with: /\A[a-zA-Z][-a-zA-Z0-9_]+\z/,
    message: 'Описание должно быть валидным'
  }
end
