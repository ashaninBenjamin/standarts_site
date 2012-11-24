class AddContentToPoints < ActiveRecord::Migration
  def change
    add_column :points, :content, :text
    remove_column :points, :content_id
  end
end
