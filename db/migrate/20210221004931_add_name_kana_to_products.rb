class AddNameKanaToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :name_kana, :string
  end
end
