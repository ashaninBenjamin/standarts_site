class AddAncestryToStandards < ActiveRecord::Migration
  def change
    add_column :standards, :ancestry, :string

    add_index :standards, :ancestry
  end
end
