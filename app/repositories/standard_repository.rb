module StandardRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :all_by_super_admin, -> { with(user_id: User.super_admins) }

    def self.stem
      with(number: 0).first.descendants
    end

  end
end