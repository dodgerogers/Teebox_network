class CreateReportsTable < ActiveRecord::Migration
  def up
       create_table :reports do |t|
         t.integer :questions
         t.float :questions_average
         t.integer :answers
         t.float :answers_average
         t.integer :users
         t.float :users_average

         t.timestamps
       end
       add_index :reports, [:questions]
       add_index :reports, [:answers]
       add_index :reports, [:users]
  end

  def down
    remove_index :reports, [:questions]
    remove_index :reports, [:answers]
    remove_index :reports, [:users]
    drop_table :reports
  end
end
