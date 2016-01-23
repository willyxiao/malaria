class AddHashToCommunity < ActiveRecord::Migration
  def change
    change_table :communities do |t|
      t.string :name, null: false
      
      t.string :hash1, null: false
      t.string :hash2, null: false
      t.string :hash3, null: false
    end
  end
end
