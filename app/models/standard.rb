# coding: utf-8
class Standard < ActiveRecord::Base
  attr_accessible :content, :name, :number, :parent_id, :user_id

  has_many :children, class_name: "Standard", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Standard"
  belongs_to :user

  validates :name, presence: true
  validates :number, presence: true
  validates :user, presence: true
  validates_associated :parent

  before_update :check_content

  scope :all_by_super_admin, scoped_by_user_id(User.super_admin)

  def self.sort_it(it)
    it.sort_by { |a| a.code.split('.').map &:to_i }
  end

  def self.find_numbers(obj)
    if (obj.class != User)
      if (!find(obj).children.any?)
        return [1]
      end
      all = where(:parent_id => obj).order("number DESC")
      last_number = all.first.number + 1
      array = (1..last_number).to_a
      all.each do |one|
        array.delete(one.number)
      end
      return array
    else
      all = where(:user_id => obj, :parent_id => nil).order("number DESC")
      if all.blank?
        return [1]
      end
      last_number = all.first.number + 1
      array = (1..last_number).to_a
      all.each do |one|
        array.delete(one.number)
      end
      return array
    end
  end

  def self.find_all_with_user(user)
    self.sort_it self.where(:user_id => user)
  end

  def for_select
    ("-" * level) + "#{code} #{name}"
  end

  def level
    temp = self
    level = 0
    while temp.parent
      level += 1
      temp = temp.parent
    end
    level
  end

  def code
    ret = self.number.to_s
    temp = self
    while temp.parent
      temp = temp.parent
      ret = temp.number.to_s + "." + ret
    end
    ret
  end

  def link
    self.code.gsub(".", "-")
  end

  def code_with_name
    "#{code}. #{name}"
  end

  def self.find_by_link(link)
    id = get_id_by_link link
    id ? find(id) : nil
  end

  def self.get_id_by_link(link)
    all.each do |one|
      return one.id if one.link == link
    end
    nil
  end

  private
  def check_content
    if self.content.eql? "<br />\r\n" || self.content.blank?
      self.content = ""
    end
  end
end