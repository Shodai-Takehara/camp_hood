class CreateCampsites < ActiveRecord::Migration[6.0]
  def change
    create_table :campsites do |t|
      t.string :name, null: false
      t.integer :prefecture_code, null: false
      t.string :address, null: false
      t.text :access
      t.text :description
      t.string :period
      t.string :checkin
      t.string :checkout
      t.string :phone
      t.text :contact_link

      t.timestamps
    end
  end
end
