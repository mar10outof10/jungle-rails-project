class CreateNewUsersTable < ActiveRecord::Migration
  def change
    drop_table :users

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end