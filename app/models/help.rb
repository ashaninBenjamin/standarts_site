class Help < ActiveRecord::Base
  include HelpRepository
  attr_accessible :content, :name, :number

  validates :number, presence: true,
            numericality: {only_integer: true},
            uniqueness: true
  validates :name, presence: true
  validates :content, presence: true

end
