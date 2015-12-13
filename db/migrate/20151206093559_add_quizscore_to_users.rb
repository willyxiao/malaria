class AddQuizscoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :quizscore, :integer
  end
end
