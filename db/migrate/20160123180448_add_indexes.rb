class AddIndexes < ActiveRecord::Migration
  def change
    add_index :schools, :name, unique: true
    add_index :communities, [:school_id, :name], unique: true
  end
end
