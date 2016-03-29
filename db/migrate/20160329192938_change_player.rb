class ChangePlayer < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.remove :state
    end
  end
end
