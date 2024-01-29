require 'rails_helper'

RSpec.feature 'Seed Data' do
  scenario 'creates products' do
    visit 'http://127.0.0.1:3000/products'  
    load Rails.root.join('db', 'seeds.rb')
    expect(Product.count).to eq(5)
  end
end
