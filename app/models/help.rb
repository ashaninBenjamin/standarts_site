class Help < ActiveRecord::Base
  attr_accessible :content, :name, :number

  default_scope order(:number)

  validates :number, :name, :content, :presence => true

  def number_with_name
    "#{number}. #{name}"
  end
end
