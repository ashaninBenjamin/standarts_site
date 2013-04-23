module NewsRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :sorted, -> { by_created_at }
  end
end