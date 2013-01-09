class Block < ActiveRecord::Base
  belongs_to :user, :primary_key => 'id', :foreign_key => 'user_id'
  #belongs_to :block_content, :primary_key => 'id', :foreign_key => 'block_content_id'

  attr_accessible :name, :content, :number
  validates :name, :presence => true
  validates :number, :presence => true
  default_scope :order => 'number'

  def find_by_number_and_user(number, user)
    where(:number => number, :user_id => user.id).first
  end

end
