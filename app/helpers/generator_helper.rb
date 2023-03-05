# frozen_string_literal: true

# filling tables in database
module GeneratorHelper
  def clients_filling
    names = parse_names

    10_000.times do |n|
      password = random_password
      Client.create!(first_name: names[n][1], surname: names[n][0], patronymic: names[n][2],
                     passport_series: random_passport_series, passport_number: random_passport_number,
                     birthday: random_birthday, phone: random_phone, password:, password_confirmation: password)
    end
  end

  def random_birthday
    Faker::Date.between(from: '1953-03-05', to: '2013-03-05')
  end

  def random_passport_series
    rand(1000..9999).to_s
  end

  def random_passport_number
    random_int_str = rand(1..999_999).to_s
    "#{'0' * (6 - random_int_str.length)}#{random_int_str}"
  end

  def random_phone
    random_int_str = rand(1..999_999_999).to_s
    "89#{'0' * (9 - random_int_str.length)}#{random_int_str}"
  end

  def random_password
    arr = Array.new(13).collect { (('a'..'z').to_a | ('A'..'Z').to_a | ('0'..'9').to_a | '!@#$%^&*'.split('')).sample }

    3.times { arr.append(complete_password(arr)) }
    arr.join
  end

  def complete_password(arr)
    if (arr & ('a'..'z').to_a).length.zero?
      ('a'..'z').to_a.sample
    elsif (arr & ('A'..'Z').to_a).length.zero?
      ('A'..'Z').to_a.sample
    elsif (arr & ('0'..'9').to_a).length.zero?
      ('0'..'9').to_a.sample
    elsif (arr & '!@#$%^&*'.split('')).length.zero?
      '!@#$%^&*'.split('').sample
    else
      (('a'..'z').to_a | ('A'..'Z').to_a | ('0'..'9').to_a | '!@#$%^&*'.split('')).sample
    end
  end

  def parse_names
    File.open("#{Rails.root}/public/names.txt", 'r:UTF-8').readlines.collect(&:split)
  end
end
