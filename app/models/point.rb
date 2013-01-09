class Point < ActiveRecord::Base
  attr_accessible :name, :content, :block_id, :code
  belongs_to :block, :primary_key => 'id', :foreign_key => 'block_id'

  has_many :child, :class_name => "Point", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Point"

  validates :name, :presence => true
  validates :content, :presence => true
  validates :code, :presence => true
  validates :block_id, :presence => true
  #default_scope :order => 'code'

  def level
    temp = self
    level = 1
    while !temp.parent.nil?
      level += 1
      temp = temp.parent
    end
    level
  end

  def number
    temp = self
    ret = temp.block.number.to_s
    while !temp.parent.nil?
      temp = temp.parent
      ret += "." + temp.code
    end
    ret + "." + self.code
  end

  def link
    self.number.gsub(".", "-")
  end

  def self.find_by_link_and_user(link, user)
    find get_id_by_link_and_user link, user
  end

  private
  def self.find_by_block_id_code_and_parent(block_id, code, parent)
    self.where(:block_id => Block.find(block_id), :parent_id => parent, :code => code).first
  end

  def self.get_id_by_link_and_user(link, user)
    id = 0
    arr = link.split("-")
    block_id = Block.where(:number => arr.first, :user_id => user.id).first.id
    tt = nil
    arr[1..arr.count-1].each do |one|
      tt = Point.find_by_block_id_code_and_parent(block_id, one, tt)
      id = tt.id
    end
    id
  end

end
