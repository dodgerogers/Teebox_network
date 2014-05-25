class AddPreferencesToUsers < ActiveRecord::Migration
  def up
    add_column :users, :preferences, :text
  end
  
  def down
    remove_column :users, :preferences
  end
end
