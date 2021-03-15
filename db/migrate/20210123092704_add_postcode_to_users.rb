class AddPostcodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :postcode, :varchar
  end
end
