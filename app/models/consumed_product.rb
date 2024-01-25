# frozen_string_literal: true

class ConsumedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :meal

  validates :quantity, presence: true
end
