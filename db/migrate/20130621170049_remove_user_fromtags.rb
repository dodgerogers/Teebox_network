class RemoveUserFromtags < ActiveRecord::Migration
  def up
    remove_column :tags, :user_id
    remove_column :tags, :question_id
  end

  def down
    add_column :tags, :user_id, :integer
    add_column :tags, :question_id, :integer
  end
end
