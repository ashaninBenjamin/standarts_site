class RemoveParentIdFromStandards < ActiveRecord::Migration
  def up
    remove_column :standards, :parent_id
  end

  def down
    add_column :standards, :parent_id, :integer
  end
end
