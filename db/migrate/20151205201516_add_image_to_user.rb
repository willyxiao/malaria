class AddImageToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :image
      t.string :email_hash
    end
  end
end
