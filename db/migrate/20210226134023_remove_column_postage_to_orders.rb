class RemoveColumnPostageToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :postage, :integer
  end
end
