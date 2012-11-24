class ChangeUsers < ActiveRecord::Migration
  def up
    remove_column :users, :password
    add_column :users, :en_password, :string
  end

  def down
  end
end
