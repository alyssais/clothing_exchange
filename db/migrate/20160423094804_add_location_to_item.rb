class AddLocationToItem < ActiveRecord::Migration
  def change
    add_column :items, :location, :text
  end
end
