class CreateVotesTable < ActiveRecord::Migration
  def up
     create_table :votes do |t|
       t.integer :value
       t.belongs_to :votable, polymorphic: true
       t.integer :user_id
       t.timestamps
     end
     add_index :votes, [:votable_id, :votable_type]
   end

   def down
     remove_index :votes, [:votable_id, :votable_type]
     drop_table :votes
   end
end
