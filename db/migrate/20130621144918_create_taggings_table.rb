class CreateTaggingsTable < ActiveRecord::Migration
  def up
    create_table :taggings do |t|
      t.belongs_to :question
      t.belongs_to :tag

      t.timestamps
    end
    add_index :taggings, [:question_id]
    add_index :taggings, [:tag_id]
  end

  def down
    remove_index :taggings, [:question_id]
    remove_index :taggings, [:tag_id]
  end
end
