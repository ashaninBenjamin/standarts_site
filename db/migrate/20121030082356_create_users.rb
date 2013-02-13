class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :en_password
      t.string :salt
      t.integer :user_info_id
      t.integer :roles_id
      t.integer :company_id
      t.timestamps
    end

    add_index :users, :login, :unique => true
  end
end
