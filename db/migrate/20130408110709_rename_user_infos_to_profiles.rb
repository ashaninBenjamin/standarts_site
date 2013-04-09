class RenameUserInfosToProfiles < ActiveRecord::Migration
  def up
    rename_table :user_infos, :profiles
    rename_column :users, :user_info_id, :profile_id
  end

  def down
    rename_table :profiles, :user_infos
    rename_column :user, :profile_id, :user_info_id
  end
end
