class AddHtmlToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :html, :text
  end
end
