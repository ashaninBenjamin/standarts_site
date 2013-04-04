class SessionHistory < ActiveRecord::Base
  attr_accessible :ip, :page, :user_id

  belongs_to :user

  default_scope order: "updated_at DESC"

  def self.find_by_user_and_ip(user, ip)
    res = where(user_id: user, ip: ip)
    if res.blank?
      []
    else
      find(res)
    end
  end
end
