module SessionHistoryRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :sorted, -> { by_updated_at }
  end
end