class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :community_id, :null => false
      t.timestamps
    end
  end
end
