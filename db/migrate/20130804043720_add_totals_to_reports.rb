class AddTotalsToReports < ActiveRecord::Migration
  def up
    add_column :reports, :answers_total, :integer
    add_column :reports, :questions_total, :integer
    add_column :reports, :users_total, :integer
  end
  
  def down
    remove_column :reports, :answers_total
    remove_column :reports, :questions_total
    remove_column :reports, :users_total
  end
end
