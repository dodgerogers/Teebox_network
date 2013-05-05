class CreateCommentsTable < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.text :content
      t.belongs_to :commentable, polymorphic: true
      t.integer :user_id
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def down
  end
end
