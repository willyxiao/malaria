class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      
      t.string :email
      t.boolean :confirmed_email, null: false, default: false

      t.string :provider, null: false
      t.string :uid, null: false
      
      t.string :oauth_token
      t.datetime :oauth_expires_at
      
      t.integer :community_id

      t.timestamps null: false
    end
  end
end
