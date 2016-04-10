class ChangeTypeToFactType < ActiveRecord::Migration
  def change
    change_table :malariafacts do |t|
      t.remove :type
      t.integer :fact_type
    end
  end
end
