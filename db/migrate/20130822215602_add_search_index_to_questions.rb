class AddSearchIndexToQuestions < ActiveRecord::Migration
  def up
      execute "create index questions_title on questions using gin(to_tsvector('english', title))"
      execute "create index questions_body on questions using gin(to_tsvector('english', body))"
    end

    def down
      execute "drop index questions_title"
      execute "drop index questions_body"
    end
end
