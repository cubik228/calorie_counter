class CreateConsumedProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :consumed_products do |t|
      t.integer :quantity
      t.integer :meal_id
      t.integer :product_id
      t.timestamps
    end
  end
end
