class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :id
      t.integer :number
      t.string :name
    end
  end
end
