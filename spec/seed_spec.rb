require 'rails_helper'


Rails.describe "Seed Data" do
  describe 'seed' do
    context "valid count create new item" do
      it "create Products" do
        load Rails.root.join('db', 'seeds.rb')
        expect(Product.count).to eq(5)
      end
    end
  end
end
