class AddBirthplaceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthplace, :text
  end
end
