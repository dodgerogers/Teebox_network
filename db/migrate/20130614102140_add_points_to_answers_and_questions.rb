class AddPointsToAnswersAndQuestions < ActiveRecord::Migration
  def up
      add_column :questions, :points, :integer, default: 0
      add_column :answers, :points, :integer, default: 0
      add_column :comments, :points, :integer, default: 0
    end

    def down
      remove_column :questions, :points
      remove_column :answers, :points
      remove_column :comments, :points
    end
end
