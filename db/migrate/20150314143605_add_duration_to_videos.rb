class AddDurationToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :duration, :string unless column_exists?(:videos, :duration)
    add_column :videos, :location, :string unless column_exists?(:videos, :location)
    add_column :videos, :name, :string unless column_exists?(:videos, :name)
    remove_column :videos, :title if column_exists?(:videos, :title)
  end
  
  def down
    remove_column :videos, :duration if column_exists?(:videos, :duration)
    remove_column :videos, :location if column_exists?(:videos, :location)
    remove_column :videos, :name if column_exists?(:videos, :name)
    add_column :videos, :title, :string unless column_exists?(:videos, :title)
  end
end
