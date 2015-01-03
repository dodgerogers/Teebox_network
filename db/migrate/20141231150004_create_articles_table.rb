class CreateArticlesTable < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :tags
      t.belongs_to :user
      t.string :cover_image
      t.string :state, default: 'draft'
      t.date :published_at
      t.integer :impressions_count, default: 0
      t.integer :votes_count, default: 0
      t.integer :comments_count, default: 0
      
      t.timestamps
    end
    add_index :articles, [:title]
    add_index :articles, [:tags]
    add_index :articles, [:user_id]
    add_index :articles, [:state]
  end
end
