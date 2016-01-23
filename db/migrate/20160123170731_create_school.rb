class CreateSchool < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.timestamps :null
    end
    
    remove_column :admins, :community_id
    add_column :admins, :school_id, :integer
    add_column :communities, :school_id, :integer
  end
end
