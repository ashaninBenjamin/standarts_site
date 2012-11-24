class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :id
      t.text :txt
      t.integer :user_id, :null => true
    end
  end
end
