module HelpRepository
  extend ActiveSupport::Concern
  include BaseRepository

  included do
    scope :web, -> { by_number }
  end
end