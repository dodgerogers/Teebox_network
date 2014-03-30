class AddStatusToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :status, :string
  end
  
  def down
    remove_column :videos, :status
  end
end