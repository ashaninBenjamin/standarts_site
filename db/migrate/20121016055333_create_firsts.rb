class CreateFirsts < ActiveRecord::Migration
  def change
    create_table :firsts do |t|
      t.integer :id
      t.string :name
      t.text :txt
    end
  end
end
