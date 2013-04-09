class Company < ActiveRecord::Base
  attr_accessible :logo, :name, :opf, :logo, :logo_cache, :remove_logo

  mount_uploader :logo, LogoUploader

  has_one :user
  has_one :profile, :through => :user

  validates :opf, presence: true
  validates :name, presence: true

  def opf_and_name
    "#{opf} #{name}"
  end
end
