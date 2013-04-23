module HelpRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :sorted, -> { by_number }
  end
end