class Block < ActiveRecord::Base
  belongs_to :user, :primary_key => 'id', :foreign_key => 'user_id'
  #belongs_to :block_content, :primary_key => 'id', :foreign_key => 'block_content_id'

  attr_accessible :name, :content, :number
  validates :name, :presence => true
  validates :number, :presence => true
  default_scope :order => 'number'

  before_save :check_content

  def find_by_number_and_user(number, user)
    where(:number => number, :user_id => user.id).first
  end

  def self.get_template
    find_all_by_user_id(User.find_by_roles_id(Role.find_by_name("super")))
  end

  private
  def check_content
    if self.content == "<br />\r\n"
      self.content = nil
    end
  end

end
