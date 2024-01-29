require 'rails_helper'

RSpec.feature 'Product Search', type: :feature do
  scenario 'user searches for a product' do
    product = FactoryBot.create(:product, name: 'Product')

    visit products_path

    fill_in 'search', with: 'Product'
    click_button 'Search'

    expect(page).to have_css('body', text: product.name)

    
  end
end
