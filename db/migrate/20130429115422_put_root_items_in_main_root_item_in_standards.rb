class PutRootItemsInMainRootItemInStandards < ActiveRecord::Migration
  def up
    User.transaction do
      User.find_each do |user|
        root = user.standards.roots.where(number: 0).first
        items = user.standards.roots.where("number != 0")
        items.each do |item|
          item.parent = root
          item.save!
        end
      end
    end
  end

  def down
  end
end
