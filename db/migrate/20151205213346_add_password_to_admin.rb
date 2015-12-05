class AddPasswordToAdmin < ActiveRecord::Migration
  def change
    change_table :admins do |t|
      t.string :email, null: false
      t.string :password, null: false
    end
  end
end
