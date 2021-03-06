class CreateVideoTable < ActiveRecord::Migration
  
  def up
    create_table :videos do |t|
      t.string :file
      t.integer :user_id
      t.integer :question_id
      t.string :screenshot
      
      t.timestamps
    end
      add_index :videos, [:user_id, :question_id]
  end

  def down
    remove_index :videos, [:user_id, :question_id]
    drop_table :videos
  end
end
