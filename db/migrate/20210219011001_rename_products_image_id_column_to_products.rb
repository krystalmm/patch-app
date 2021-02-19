class RenameProductsImageIdColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :products_image_id, :product_image
  end
end
