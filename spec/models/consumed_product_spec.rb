# spec/models/consumed_product_spec.rb
require 'rails_helper'

RSpec.describe ConsumedProduct, type: :model do

  context 'factory' do
    it 'has a valid factory Product model' do
      expect(create(:product)).to be_valid
    end
  end
  
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:meal) }
  end
end
