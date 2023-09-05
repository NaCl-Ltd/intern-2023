class CreateBads < ActiveRecord::Migration[7.0]
  def change
    create_table :bads do |t|

      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true


      t.timestamps
    end
  end
end
