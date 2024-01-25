FactoryBot.define do
  factory :meal do
    name { Faker::Lorem.word }
    total_calories { Faker::Number.number(digits: 4) }
    date { Faker::Date.in_date_period }
    user
  end
end
  