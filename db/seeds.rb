# frozen_string_literal: true

Product.destroy_all
Meal.destroy_all
User.destroy_all

5.times do
  Product.create!(
    name: Faker::Food.dish,
    calories_count: Faker::Number.number(digits: 3)
  )
end
puts "Created #{Product.count} Products"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?