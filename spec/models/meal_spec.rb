# frozen_string_literal: true

# spec/models/meal_spec.rb
require 'rails_helper'

RSpec.describe Meal, type: :model do
  context 'factory' do
    it 'has a valid factory Product model' do
      expect(create(:product)).to be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:total_calories) }
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
