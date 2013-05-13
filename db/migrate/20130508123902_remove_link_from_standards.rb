class RemoveLinkFromStandards < ActiveRecord::Migration
  def up
    remove_column :standards, :link
  end

  def down
    add_column :standards, :link, :string
  end
end
