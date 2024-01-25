class Meal < ApplicationRecord
  belongs_to :user
  has_many :consumed_products
end
