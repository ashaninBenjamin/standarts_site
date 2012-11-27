class DropSomeTables < ActiveRecord::Migration
  def up
    drop_table :block_contents
    drop_table :blocks_old
    drop_table :firsts
    drop_table :sqlite_stat1
  end

  def down
  end
end
