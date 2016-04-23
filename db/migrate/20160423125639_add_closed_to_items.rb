class AddClosedToItems < ActiveRecord::Migration
  def change
    add_column :items, :closed, :boolean, null: false, default: false
  end
end
