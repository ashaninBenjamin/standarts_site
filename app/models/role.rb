class Role < ActiveRecord::Base
  include RoleRepository
  attr_accessible :name, :description

  has_many :users

  def super_role?
    name.eql? "super"
  end

  def admin_role?
    name.eql? "admin"
  end

end