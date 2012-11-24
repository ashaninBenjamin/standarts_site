class AddCodeToPoints < ActiveRecord::Migration
  def change
    add_column :points, :code, :string
  end
end
