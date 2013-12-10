class CreatePointsTable < ActiveRecord::Migration
  def up
    create_table :points do |t|
      t.integer :user_id
      t.belongs_to :pointable, polymorphic: true
      t.integer :value
      t.timestamps
    end
    add_index :points, [:pointable_id, :pointable_type]
    add_index :points, :user_id
  end

  def down
  end
end
