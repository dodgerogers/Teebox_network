class CreateQuestionsTable < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.string :youtube_url
      
      t.timestamps
    end
    add_index :questions, [:title, :user_id]
  end

  def down
    remove_index :questions, [:title, :user_id]
    drop_table :questions
  end
end
