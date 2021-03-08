class RemoveColumnRateToComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :rate, :float
  end
end
