class CreateKillstory < ActiveRecord::Migration
  def change
    create_table :killstories do |t|
      t.integer :game_id, :null => false
      t.integer :killer_id, :null => false
      t.integer :dead_id, :null => false
      t.text :story
      t.boolean :is_kill_story, :null => false
      t.timestamps
    end
  end
end
