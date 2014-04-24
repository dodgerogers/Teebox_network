class AddCommentsCounterCacheToAnswersAndQuestion < ActiveRecord::Migration
  def up
    add_column :questions, :comments_count, :integer, default: 0
    add_column :answers, :comments_count, :integer, default: 0
    
    # Now we need to update both columns
    [Question, Answer].each do |model|
      model.reset_column_information
      model.all.each do |object|
        model.update_counters(object.id, comments_count: object.comments.length)
      end
    end
  end
  
  def down
    remove_column :questions, :comments_count
    remove_column :answers, :comments_count
  end
end
