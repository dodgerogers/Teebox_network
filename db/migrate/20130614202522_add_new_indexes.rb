class AddNewIndexes < ActiveRecord::Migration
  def up
    #answers
    add_index :answers, [:question_id]
    add_index :answers, [:user_id]
    
    #comments
    add_index :comments, [:commentable_id]
    add_index :comments, [:commentable_type]
    add_index :comments, [:user_id]
    
    #questions
    add_index :questions, [:user_id]
    
    #videos
    add_index :videos, [:user_id]
    add_index :videos, [:question_id]
  end

  def down
    remove_index :answers, [:question_id]
    remove_index :answers, [:user_id]
    remove_index :comments, [:commentable_id]
    remove_index :comments, [:commentable_type]
    remove_index :comments, [:user_id]
    remove_index :questions, [:user_id]
    remove_index :videos, [:user_id]
    remove_index :videos, [:question_id]
  end
end
