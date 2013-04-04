class Draft < ActiveRecord::Base
  attr_accessible :content, :name, :user_id

  validates :name, presence: true
  validates :content, presence: true
  validates :user, presence: true

  belongs_to :user
end
