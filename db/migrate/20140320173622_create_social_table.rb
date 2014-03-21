class CreateSocialTable < ActiveRecord::Migration
  def up
    create_table :socials do |t|
      t.integer :likes
      t.integer :followers
      t.timestamps
    end
  end

  def down
    drop_table :socials
  end
end
