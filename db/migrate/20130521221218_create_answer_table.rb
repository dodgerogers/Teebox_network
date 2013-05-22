class CreateAnswerTable < ActiveRecord::Migration
  def up
    create_table :answers do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
      
      t.timestamps
    end
    add_index :answers, [:user_id, :question_id]
  end

  def down
    remove_index :answers, [:user_id, :question_id]
    drop_table :answers
  end
end
