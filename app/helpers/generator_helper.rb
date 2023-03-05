# frozen_string_literal: true

# filling tables in database
module GeneratorHelper
  def clients_filling
    names = parse_names

    40_000.times do |n|
      password = random_password
      Client.create!(first_name: names[n][1], surname: names[n][0], patronymic: names[n][2],
                     passport_series: random_passport_series, passport_number: random_passport_number,
                     birthday: random_birthday, phone: random_phone, password:, password_confirmation: password)
    end
  end

  def banned_clients_filling
    100.times { @temp << { client_id: rand(10_029..50_028), reason: Faker::Lorem.paragraph } }
    BannedClient.insert_all(@temp)
  end

  def speech_therapist_filling
    5_000.times { @temp << { client_id: rand(10_029..42_459) } }
    SpeechTherapist.insert_all(@temp)
  end

  def services_filling
    50_000.times do
      @temp << { price_per_hour: rand(1..10) * 1000, description: Faker::Lorem.paragraph,
                 speech_therapist_id: rand(5_002..10_001) }
    end
    Service.insert_all(@temp)
  end

  def rates_filling
    100_000.times do
      @temp << { count: rand(1..5), speech_therapist_id: rand(5_002..10_001), client_id: rand(10_029..42_459) }
    end
    Rate.insert_all(@temp)
  end

  def comments_filling
    100_000.times do
      @temp << { body: Faker::Lorem.paragraph, client_id: rand(10_029..42_459),
                 speech_therapist_id: rand(5_002..10_001) }
    end
    Comment.insert_all(@temp)
  end

  def contracts_filling
    500_000.times do
      random_service = rand(50_001..100_000)
      random_service_price = Service.find(random_service).price_per_hour
      random_hours = rand(1..20)
      @temp << { issue_date: random_issue_date, hours: random_hours, total_cost: random_service_price * random_hours,
                 service_id: random_service, client_id: rand(10_029..42_459) }
    end

    Contract.insert_all(@temp)
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

  def random_issue_date
    Faker::Date.between(from: '2020-01-01', to: '2023-02-06')
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
