class CreateVideoTable < ActiveRecord::Migration
  
  def up
    create_table :videos do |t|
      t.string :video
      t.integer :user_id
      t.integer :question_id
      t.string :name
      t.string :youtube_url
      
      t.timestamps
    end
      add_index :videos, [:user_id, :question_id]
  end

  def down
    remove_index :videos, [:user_id, :question_id]
    drop_table :videos
  end
end
