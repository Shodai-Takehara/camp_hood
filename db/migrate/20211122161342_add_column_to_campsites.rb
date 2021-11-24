class AddColumnToCampsites < ActiveRecord::Migration[6.0]
  def change
    add_column :campsites, :image, :string
  end
end
