class AddCorrectToAnswers < ActiveRecord::Migration
  def up
    add_column :answers, :correct, :boolean, default: false
  end
  
  def down
    remove_column :answers, :correct
  end
end
