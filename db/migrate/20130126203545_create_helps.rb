class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.string :name
      t.text :content
      t.integer :number
    end
  end
end
