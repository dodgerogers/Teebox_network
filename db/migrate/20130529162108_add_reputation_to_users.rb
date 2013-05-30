class AddReputationToUsers < ActiveRecord::Migration
  def up
    add_column :users, :reputation, :integer, default: 0
  end
  
  def down
    remove_column :users, :reputation
  end
end
