module UserRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :super_admins, -> { with(role_id: Role.super_roles) }
  end
end