# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :service

  validates :hours, presence: { message: 'Количество часов не может быть пустым' }
  validates :total_cost, presence: { message: 'Итоговая сумма не может быть пустой' }
  validates :client_id, presence: { message: 'Идентификатор не может быть пустым' }
  validates :service_id, presence: { message: 'Идентификатор услуги не может быть пустым' }
end
