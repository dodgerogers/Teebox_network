class RemoveIndexes < ActiveRecord::Migration
  def up
    remove_index :answers, column: [:user_id,:question_id]
    remove_index :comments, column: [:commentable_id, :commentable_type]
    remove_index :questions, column: [:title, :user_id]
    remove_index :videos, column: [:user_id, :question_id]
    remove_index :votes, column: [:votable_id, :votable_type]
  end

  def down
  end
end
