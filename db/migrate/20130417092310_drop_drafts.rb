class DropDrafts < ActiveRecord::Migration
  def change
    drop_table :drafts
  end
end
