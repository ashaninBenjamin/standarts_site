class SessionHistory < ActiveRecord::Base
  attr_accessible :ip, :page, :user_id

  belongs_to :user
end
