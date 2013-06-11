class AddPointsToVote < ActiveRecord::Migration
  def up
     add_column :votes, :points, :integer, default: 0
   end

   def down
     remove_column :votes, :points
   end
end
