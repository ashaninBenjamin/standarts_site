class SessionHistory < ActiveRecord::Base
  include UsefullScopes
  attr_accessible :ip, :page, :user_id

  belongs_to :user

end
