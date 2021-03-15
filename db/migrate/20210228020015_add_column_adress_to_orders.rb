class AddColumnAdressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :postcode, :string
    add_column :orders, :prefecture_code, :integer
    add_column :orders, :address_city, :string
    add_column :orders, :address_street, :string
    add_column :orders, :address_building, :string
  end
end
