class AddScreenmode < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :screen_mode, :boolean
  end
end
