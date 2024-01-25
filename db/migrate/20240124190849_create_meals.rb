# frozen_string_literal: true

class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :total_calories
      t.string :date
      t.integer :user_id
      t.timestamps
    end
  end
end
