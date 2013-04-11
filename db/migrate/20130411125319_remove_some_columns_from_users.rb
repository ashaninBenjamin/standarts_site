class RemoveSomeColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :en_password
    remove_column :users, :salt
  end

  def down
    add_column :users, :salt, :string
    add_column :users, :en_password, :string
  end
end
