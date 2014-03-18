class CreateImpressionsTable < ActiveRecord::Migration
  def up
    create_table :impressions do |t|
      t.belongs_to :impressionable, polymorphic: true
      t.string :ip_address
    end
  end

  def down
    drop_table :impressions
  end
end
