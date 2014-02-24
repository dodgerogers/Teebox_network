class CreatePlaylistTable < ActiveRecord::Migration
  def up
    create_table :playlists do |t|
      t.belongs_to :question
      t.belongs_to :video
      t.timestamps
    end
    add_index :playlists, [:question_id]
    add_index :playlists, [:video_id]
  end

  def down
    remove_index :playlists, [:question_id]
    remove_index :playlists, [:video_id]
    drop_table :playlists
  end
end
