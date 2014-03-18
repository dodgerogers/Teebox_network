class AddImpressionsCountToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :impressions_count, :integer, default: 0
  end
  
  def down
    remove_column :questions, :impressions_count
  end
end
