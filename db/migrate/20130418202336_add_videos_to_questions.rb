class AddVideosToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :video, :integer
  end
end
