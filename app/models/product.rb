# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :consumed_products

  validates :name, presence: true
  validates :calories_count, presence: true
end
