class CreateMalariafacts < ActiveRecord::Migration
  def change
    create_table :malariafacts do |t|
      t.integer :type, null: false
      t.text :content
      t.timestamps null: false
    end
  end
end
