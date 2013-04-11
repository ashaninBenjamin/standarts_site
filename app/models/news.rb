class News < ActiveRecord::Base
  attr_accessible :content, :title

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> { order('created_at DESC') }

end
