class CreateTagsTable < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name
      t.text :explanation
      t.integer :question_id
      t.string :updated_by
      t.integer :user_id
      
      t.timestamps
    end
      add_index :tags, [:user_id]
      add_index :tags, [:question_id]
  end

  def down
      remove_index :tags, [:user_id]
      remove_index :tags, [:question_id]
      drop_table :tags
  end
end
