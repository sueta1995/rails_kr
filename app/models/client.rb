# frozen_string_literal: true

class Client < ApplicationRecord
  has_secure_password

  has_many :comments, dependent: :destroy

  has_one :banned_client, dependent: :destroy
  has_one :speech_therapist, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  # validates :password, presence: { message: 'Пароль не может быть пустым' }
  validates :password_confirmation, presence: { message: 'Поле подтверждения пароля не может быть пустым' }

  validates :phone, uniqueness: { message: 'Пользователь с данным телефоном уже существует' }

  validates :first_name, :surname, :patronymic, format: {
    with: /\A[а-яА-ЯёЁ]{2,23}+\z/,
    message: 'Имя, фамилия и отчество должны быть валидными'
  }

  validates :phone, format: {
    with: /\A89[0-9]{9}+\z/,
    message: 'Введите валидный телефон'
  }

  validates :passport_series, format: {
    with: /\A[0-9]{4}+\z/,
    message: 'Введите валидную серию пасспорта'
  }

  validates :passport_number, format: {
    with: /\A[0-9]{6}+\z/,
    message: 'Введите валидный номер пасспорта'
  }

  validates :password, format: {
    with: /(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*]{6,}/,
    message: 'Пароль должен быть валидным'
  }

  validates :birthday, format: {
    with: /(19[0-9][0-9]|20[0-1][0-9])-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[0-1])/,
    message: 'Дата рождения должна быть валидной'
  }

  validates :password, confirmation: { message: 'Пароли не совпадают' }
end
