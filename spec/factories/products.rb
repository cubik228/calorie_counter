# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    calories_count { Faker::Number.number(digits: 4) }
  end
end
