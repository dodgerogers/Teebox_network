class RemoveReportsAverages < ActiveRecord::Migration
  def change
    remove_column :reports, :questions_average
    remove_column :reports, :answers_average
    remove_column :reports, :users_average
  end
end
