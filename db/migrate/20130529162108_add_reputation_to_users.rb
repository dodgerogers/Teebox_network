class AddReputationToUsers < ActiveRecord::Migration
  def up
    add_column :users, :reputation, :integer, default: 0
    add_column :questions, :answers_count, :integer, default: 0
  end
  
  def down
    remove_column :users, :reputation
    remove_column :questions, :answers_count
  end
end
