# frozen_string_literal: true

# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'factory' do
    it 'has a valid factory Product model' do
      expect(create(:product)).to be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:calories_count) }
  end
  describe 'seed data' do
    before do
      load Rails.root.join('db', 'seeds.rb')
    end

    it 'creates 5 products' do
      expect(Product.count).to eq(5)
    end

    it 'creates products with valid attributes' do
      Product.all.each do |product|
        expect(product.name).to be_present
        expect(product.calories_count).to be_present
      end
    end
  end
end
