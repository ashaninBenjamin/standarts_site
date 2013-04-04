class RenameRoleAtUsers < ActiveRecord::Migration
  def up
    rename_column :users, :roles_id, :role_id
  end

  def down
    rename_column :users, :role_id, :roles_id
  end
end
