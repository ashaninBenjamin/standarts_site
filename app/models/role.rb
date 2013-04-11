class Role < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :users

  scope :super_roles, -> { where(name: "super") }
  scope :admin_roles, -> { where(name: "admin") }

  def super_role?
    name.eql? "super"
  end

  def admin_role?
    name.eql? "admin"
  end

end