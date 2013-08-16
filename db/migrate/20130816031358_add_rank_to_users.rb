class AddRankToUsers < ActiveRecord::Migration
  def up
    add_column :users, :rank, :integer, default: 0
  end
  
  def down
    remove_column :users, :rank
  end
end
