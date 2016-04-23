class RemoveEmailFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :email, :text
  end
end
