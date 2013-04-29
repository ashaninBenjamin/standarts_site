class AddLinkToStandards < ActiveRecord::Migration
  def change
    add_column :standards, :link, :string
  end
end
