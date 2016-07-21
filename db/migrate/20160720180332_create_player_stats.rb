class CreatePlayerStats < ActiveRecord::Migration
  def change
    create_table :player_stats do |t|
      t.integer :player_id
      t.integer :game_id
      t.float :total_time_alive
      t.datetime :time_dead
      t.float :kill_rate_by_day
      t.integer :number_of_kills
      t.integer :rank_died_at
      t.timestamps null: false
    end
  end
end
