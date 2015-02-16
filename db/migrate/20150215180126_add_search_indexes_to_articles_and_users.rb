class AddSearchIndexesToArticlesAndUsers < ActiveRecord::Migration
  def up
    execute "create index articles_title on articles using gin(to_tsvector('english', title))"
    execute "create index users_username on users using gin(to_tsvector('english', username))"
  end

  def down
    execute "drop index articles_title"
    execute "drop index users_username"
  end
end
