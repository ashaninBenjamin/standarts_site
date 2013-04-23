class News < ActiveRecord::Base
  include UsefullScopes
  attr_accessible :content, :title

  validates :title, presence: true
  validates :content, presence: true

end
