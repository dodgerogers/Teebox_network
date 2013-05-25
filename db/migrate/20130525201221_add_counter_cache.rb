class AddCounterCache < ActiveRecord::Migration
  def up
    add_column :questions, :votes_count, :integer, default: 0
    add_column :comments, :votes_count, :integer, default: 0
    add_column :answers, :votes_count, :integer, default: 0
  end

  def down
    remove_column :questions, :votes_count
    remove_column :comments, :votes_count
    remove_column :answers, :votes_count
  end
end
