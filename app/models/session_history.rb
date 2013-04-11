class SessionHistory < ActiveRecord::Base
  attr_accessible :ip, :page, :user_id

  belongs_to :user

  scope :sorted, -> { order("updated_at DESC") }

end
