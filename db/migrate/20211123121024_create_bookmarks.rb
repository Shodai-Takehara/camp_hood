class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :campsite, foreign_key: true

      t.timestamps
    end
    add_index :bookmarks, [:user_id, :campsite_id], unique: true
  end
end
