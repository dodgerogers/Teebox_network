class AddTagsToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :tags, :string
    add_index :questions, [:tags]
  end
  
  def down
    remove_column :questions, :tags
    remove_index :questions, [:tags]
  end
end
