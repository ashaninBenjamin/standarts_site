class AddMainRootItemForEachUserInStandards < ActiveRecord::Migration
  def up
    User.transaction do
      User.find_each do |user|
        Standard.create!(name: "root", number: 0, user_id: user.id)
      end
    end
  end

  def down
  end
end
