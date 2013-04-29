class FillLinkFieldInStandards < ActiveRecord::Migration
  def up
    Standard.transaction do
      Standard.find_each do |standard|
        standard.link = standard.decorate.link
        standard.save!
      end
    end
  end

  def down
  end
end
