class Help < ActiveRecord::Base
  attr_accessible :content, :name, :number

  validates :number, presence: true,
            numericality: {only_integer: true},
            uniqueness: true
  validates :name, presence: true
  validates :content, presence: true

  scope :sorted, -> { order(:number) }

end
