class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :community_id, :null => false
      t.datetime :time_started, :null => false
      t.timestamps
    end
  end
end
