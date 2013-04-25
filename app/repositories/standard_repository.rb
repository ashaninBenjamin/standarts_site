module StandardRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :all_by_super_admin, -> { with(user_id: User.super_admins) }
  end
end