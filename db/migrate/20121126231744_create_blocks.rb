#createBlocks id:integer number:integer name:text content:text is_show:integer user_id:integer
class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :id
      t.integer :number
      t.text :name
      t.text :content
      t.integer :is_show
      t.integer :user_id
      end
  end
end

