# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :user
  has_many :consumed_products

  validates :name, presence: true
  validates :total_calories, presence: true
  validates :date, presence: true
end
