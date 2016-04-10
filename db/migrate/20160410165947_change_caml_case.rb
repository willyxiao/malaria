class ChangeCamlCase < ActiveRecord::Migration
  def change
    change_table :malariafactviews do |t|
      t.remove :malaria_fact_id
      t.integer :malariafact_id, null: false
    end
  end
end
