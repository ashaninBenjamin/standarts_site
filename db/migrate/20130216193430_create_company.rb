class CreateCompany < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :opf
      t.string :logo

      t.timestamps
    end
  end
end
