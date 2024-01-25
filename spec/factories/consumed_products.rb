FactoryBot.define do
  factory :consumed_product do
    quantity { Faker::Number.number(digits: 1) }
    product
    meal
  end
end
