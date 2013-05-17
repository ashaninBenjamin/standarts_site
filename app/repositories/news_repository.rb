module NewsRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :web, -> { by_created_at }
  end
end