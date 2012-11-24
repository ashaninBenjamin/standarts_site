class CreateBlockContents < ActiveRecord::Migration
  def change
    create_table :block_contents do |t|
      t.integer :id
      t.text :txt
    end
  end
end
