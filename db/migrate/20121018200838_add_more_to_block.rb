class AddMoreToBlock < ActiveRecord::Migration
  def change
    add_column :blocks, :user_id, :integer
    add_column :blocks, :block_content_id, :integer
  end
end
