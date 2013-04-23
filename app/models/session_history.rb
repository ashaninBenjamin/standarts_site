class SessionHistory < ActiveRecord::Base
  include SessionHistoryRepository
  attr_accessible :ip, :page, :user_id

  belongs_to :user

end
