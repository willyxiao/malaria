class CreateMalariafactviews < ActiveRecord::Migration
  def change
    create_table :malariafactviews do |t|
      t.integer :user_id, null: false
      t.integer :malaria_fact_id, null: false
      t.boolean :shown
      t.string :action
      t.timestamps null: false
    end
  end
end
