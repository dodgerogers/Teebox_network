class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :votes, [:votable_id, :votable_type]
    add_index :votes, :user_id
  end
end