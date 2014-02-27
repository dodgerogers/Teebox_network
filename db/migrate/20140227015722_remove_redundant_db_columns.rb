class RemoveRedundantDbColumns < ActiveRecord::Migration
  def up
    remove_column :questions, :video_id
    remove_column :questions, :points
    remove_column :videos, :question_id
    remove_column :comments, :points
    remove_column :answers, :points
  end

  def down
    add_column :questions, :video_id, :integer
    add_column :questions, :points, :integer
    add_column :videos, :question_id, :integer
    add_column :comments, :points, :integer
    add_column :answers, :points, :integer
  end
end
