# frozen_string_literal: true

class BannedClient < ApplicationRecord
  belongs_to :client

  validates :client_id, presence: { message: 'Идентификатор не может быть пустым' }

  validates :client_id, uniqueness: { message: 'Данный пользователь уже заблокирован' }
end
