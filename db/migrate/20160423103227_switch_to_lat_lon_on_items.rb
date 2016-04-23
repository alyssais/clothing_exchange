class SwitchToLatLonOnItems < ActiveRecord::Migration
  def change
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float
    add_column :items, :city, :text
    Item.all.map { |i| i.tap(&:geocode).save! }
  end
end
