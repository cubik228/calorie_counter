# spec/features/meal_search_spec.rb
require 'rails_helper'

RSpec.feature 'Meal Search', type: :feature do
  scenario 'user searches for a meal' do
    user = FactoryBot.create(:user)
    meal = FactoryBot.create(:meal, name: 'Meal', user: user)

    login_as(user, scope: :user)
    visit meals_path

    fill_in 'search', with: 'Meal'
    click_button 'Search'

    expect(page).to have_css('body', text: meal.name)
  end
end
