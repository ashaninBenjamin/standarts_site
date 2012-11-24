class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :id
      t.integer :parent_id, :null => true
      t.integer :block_id
      t.integer :content_id
      t.string :name
    end
  end
end
