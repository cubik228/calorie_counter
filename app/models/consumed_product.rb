class ConsumedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :meal
end
