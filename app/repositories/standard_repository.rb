module StandardRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :all_by_super_admin, -> { with(user_id: User.super_admins) }

    def self.find_by_link(link)
      scoped.each do |one|
        return one if one.decorate.link == link
      end
      nil
    end

    def siblings
      Standard.where(ancestry: self.ancestry, user_id: self.user)
    end

  end
end