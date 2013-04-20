class AddVideosToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :video_id, :integer, default: 0
  end
end
