class Role < ActiveRecord::Base
  attr_accessible :name, :description

  def self.super_role
    self.find_by_name("super")
  end

  def self.admin_role
    self.find_by_name("admin")
  end

end