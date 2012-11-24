class AddLevelToPoints < ActiveRecord::Migration
  def change
    add_column :points, :level, :integer
  end
end
