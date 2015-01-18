class AddVideosCounterCacheToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :videos_count, :integer, default: 0
    
    Question.reset_column_information
    Question.all.each do |question|
      Question.update_counters(question.id, videos_count: question.videos.length)
    end
  end
  
  def down
    remove_column :questions, :videos_count
  end
end
