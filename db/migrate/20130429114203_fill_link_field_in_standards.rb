class FillLinkFieldInStandards < ActiveRecord::Migration
  def up
    Standard.transaction do
      Standard.find_each do |standard|
        link = standard.number.to_s
        temp = standard
        while temp.parent && temp.parent.number.nonzero?
          temp = temp.parent
          link = "#{temp.number}-#{link}"
        end
        standard.link = link
        standard.save!
      end
    end
  end

  def down
  end
end
