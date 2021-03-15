class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :name_kana
      t.integer :price, null: false
      t.text :description
      t.string :product_image
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
