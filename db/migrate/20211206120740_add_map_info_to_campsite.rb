class AddMapInfoToCampsite < ActiveRecord::Migration[6.0]
  def change
    add_column :campsites, :latitude, :float
    add_column :campsites, :longitude, :float
  end
end
