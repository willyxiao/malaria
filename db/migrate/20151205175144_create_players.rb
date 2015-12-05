class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :community_id, :null => false
      t.integer :user_id, :null => false
      t.integer :game_id, :null => false
      t.integer :target_id
      t.boolean :state, :null => false, :default => true
      t.timestamps
    end
  end
end
