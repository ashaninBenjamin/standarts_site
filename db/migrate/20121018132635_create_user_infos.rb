class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.string :mail
      t.attachment :avatar

      t.timestamps
    end
  end
end
