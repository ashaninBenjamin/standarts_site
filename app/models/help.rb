class Help < ActiveRecord::Base
  attr_accessible :content, :name, :number

  default_scope order(:number)

  validates :number, presence: true,
            numericality: {only_integer: true},
            uniqueness: true
  validates :name, presence: true
  validates :content, presence: true

  def number_with_name
    "#{number}. #{name}"
  end
end
