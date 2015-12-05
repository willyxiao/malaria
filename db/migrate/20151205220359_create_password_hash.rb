class CreatePasswordHash < ActiveRecord::Migration
  def change
    change_table :admins do |t|
      t.remove :password
      t.string :password_hash
    end
  end
end
