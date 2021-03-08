class ChangeColumnAddNotnullOnComments < ActiveRecord::Migration[6.0]
  def change
    change_column_null :comments, :comment, false
  end
end
