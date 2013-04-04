class UserInfo < ActiveRecord::Base
  attr_accessible :name, :surname, :patronymic, :mail, :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "40x40>" }

  has_one :user, dependent: :destroy
  has_one :company, :through => :user

  #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']

  validates :surname, :name, :mail, :presence => true
  validates :mail, :email => true, :uniqueness => true

  def fi
    "#{surname} #{name}"
  end
end
