class ChangePaperclipOnCarrierware < ActiveRecord::Migration
  def up
    remove_attachment :user_infos, :avatar
    add_column :user_infos, :avatar, :string

    remove_attachment :companies, :logo
    add_column :companies, :logo, :string
  end

  def down
    remove_column :user_infos, :avatar
    add_attachment :users, :avatar

    remove_column :companies, :logo
    add_attachment :companies, :logo
  end
end
