class AddColumnsToStandards < ActiveRecord::Migration
  def change
    add_column :standards, :state, :string
    add_column :standards, :access_state, :string
    remove_column :standards, :show_number, :turn_on
  end
end
