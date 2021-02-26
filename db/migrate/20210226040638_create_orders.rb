class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :card, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity, null: false
      t.integer :status, default: 0, null: false
      t.integer :postage, default: 0, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
