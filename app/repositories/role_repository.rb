module RoleRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :super_roles, -> { like_by_name "super" }
    scope :admin_roles, -> { like_by_name "admin" }
  end
end