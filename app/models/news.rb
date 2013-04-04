class News < ActiveRecord::Base
  attr_accessible :content, :title

  validates :title, presence: true
  validates :content, presence: true

  default_scope order('created_at DESC')
end
