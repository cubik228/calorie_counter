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
end
