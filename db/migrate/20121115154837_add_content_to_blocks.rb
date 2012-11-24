class AddContentToBlocks < ActiveRecord::Migration
  def change
    remove_column :blocks, :block_content
    add_column :blocks, :content, :text

  end
end
