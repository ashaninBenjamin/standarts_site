class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :login
      t.string :password
      t.integer :user_info_id
      t.integer :roles_id
      t.timestamps
    end

    add_index :users, :login, :unique => true
  end
end
