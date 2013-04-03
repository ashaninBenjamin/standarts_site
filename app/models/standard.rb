# coding: utf-8
class Standard < ActiveRecord::Base
  attr_accessible :content, :name, :number, :parent_id, :user_id

  has_many :children, :class_name => "Standard", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Standard"
  belongs_to :user

  validates :name, :number, :presence => true
  validates :parent_id, :confirmation => :parent_id != :id

  before_update :check_content
  before_destroy :destroy_children

  def self.find_all_by_super_admin
    find_all_by_user_id(User.super_admin)
  end

  def self.sort_it(it)
    it.sort_by { |a| a.code.split('.').map &:to_i }
  end

  def self.find_numbers(obj)
    if (obj.class != User)
      if (!find(obj).has_children?)
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

  def has_parent?
    (parent.nil?) ? false : true
  end

  def has_children?
    (children.empty?) ? false : true
  end

  def self.find_by_link(link, user)
    find get_id_by_link_and_user link, user
  end

  def self.get_id_by_link_and_user(link, user)
    id = 0
    arr = link.split("-")
    tt = nil
    arr[0..arr.count-1].each do |one|
      tt = Standard.where(:parent_id => tt, :number => one, :user_id => user.id).first
      id = tt.id
    end
    id
  end

  private
  def check_content
    if self.content.eql? "<br />\r\n" || self.content.blank?
      self.content = ""
    end
  end

  def destroy_children
    self.children.each { |one| one.destroy } if self.has_children?
  end


end
