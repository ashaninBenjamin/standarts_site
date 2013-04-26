class Company < ActiveRecord::Base
  attr_accessible :logo, :name, :opf, :logo, :logo_cache, :remove_logo

  has_one :user
  has_one :profile, through: :user

  validates :opf, presence: true
  validates :name, presence: true

  mount_uploader :logo, LogoUploader

end
