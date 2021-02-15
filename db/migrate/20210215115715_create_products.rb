class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price
      t.text :description
      t.string :products_image_id
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
