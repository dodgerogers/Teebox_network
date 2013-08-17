class AddReadToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :read, :boolean, default: false
  end
  
  def down
    remove_column :activities, :read
  end
end
