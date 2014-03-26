class AddJobidToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :job_id, :string
  end
  
  def down
    remove_column :videos, :job_id
  end
end
