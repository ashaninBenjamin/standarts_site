class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :id
      t.string :surname
      t.string :name
      t.string :patronymic
      t.string :mail
    end
  end
end
