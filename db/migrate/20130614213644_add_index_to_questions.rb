class AddIndexToQuestions < ActiveRecord::Migration
  def up
    add_index :questions, [:video_id]
  end
  
  def down
    remove_index :questions, [:video_id]
  end
end
