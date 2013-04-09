class Profile < ActiveRecord::Base
  attr_accessible :name, :surname, :patronymic, :mail, :avatar, :avatar_cache, :remove_avatar

  mount_uploader :avatar, AvatarUploader

  has_one :user
  has_one :company, :through => :user

  validates :surname, presence: true
  validates :name, presence: true
  validates :mail, presence: true, email: true, uniqueness: true

  def fi
    "#{surname} #{name}"
  end
end
