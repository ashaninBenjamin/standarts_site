class Draft < ActiveRecord::Base
  attr_accessible :content, :name, :user_id

  validates :name, :content, :user_id, :presence => true

  belongs_to :user
end
