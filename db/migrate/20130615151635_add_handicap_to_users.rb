class AddHandicapToUsers < ActiveRecord::Migration
  def up
    add_column :users, :handicap, :integer, default: 0
  end
  
  def down
    remove_column :users, :handicap
  end
end
