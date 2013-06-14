class AddCorrectToQuestions < ActiveRecord::Migration
  def up
      add_column :questions, :correct, :boolean, default: false
    end

    def down
      remove_column :questions, :correct
    end
end
