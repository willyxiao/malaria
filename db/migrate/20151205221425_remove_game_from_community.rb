class RemoveGameFromCommunity < ActiveRecord::Migration
  def change
    change_table :communities do |t|
      t.remove :game_id
    end
  end
end
