class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.integer :game_id, :null =>false
      t.timestamps
    end
  end
end
