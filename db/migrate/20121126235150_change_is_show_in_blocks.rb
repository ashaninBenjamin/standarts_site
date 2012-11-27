class ChangeIsShowInBlocks < ActiveRecord::Migration
  def up
    change_column :blocks, :is_show, :text
  end

  def down
    change_column :blocks, :is_show, :integer
  end
end
