# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :user
  has_many :consumed_products

  validates :name, presence: true, length: { minimum: 4 }
  validate :name_should_be_in_english

  validates :date, presence: true

  private

  def name_should_be_in_english
    return if name =~ /\A[a-zA-Z]+\z/

    errors.add(:name, 'should contain only English letters')
  end
end
