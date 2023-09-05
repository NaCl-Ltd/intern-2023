class AddDeletedFlagToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :deleted_flag, :boolean, default: false
  end
end
