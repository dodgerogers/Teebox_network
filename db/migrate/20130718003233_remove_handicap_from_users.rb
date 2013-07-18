class RemoveHandicapFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :handicap
  end
  
  def down
    add_column :users, :handicap, :integer
  end
end
