class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.integer :number
      t.string :name
      t.text :content
      t.integer :parent_id
      t.integer :user_id
      t.string :show_number
      t.string :turn_on
    end
  end
end
