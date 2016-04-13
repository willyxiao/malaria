class CreateSiteEvents < ActiveRecord::Migration
  def change
    create_table :site_events do |t|
      t.string :event, null: false
      t.timestamps null: false
    end
  end
end
