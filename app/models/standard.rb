# coding: utf-8
class Standard < ActiveRecord::Base
  attr_accessible :content, :name, :number, :user_id, :parent_id, :state, :access_state

  has_ancestry
  belongs_to :user

  validates :name, presence: true
  validates :number, presence: true
  validates :user, presence: true

  state_machine :state, initial: :standard do
    state :standard
    state :draft

    event :draft do
      transition :standard => :draft
    end

    event :standard do
      transition :draft => :standard
    end

  end

  state_machine :access_state, initial: :private do
    state :private
    state :public
    state :super_admin

    event :private do
      transition all => :private
    end

    event :public do
      transition all => :public
    end

    event :super_admin do
      transition all => :super_admin
    end
  end

  before_update :check_content

  scope :all_by_super_admin, scoped_by_user_id(User.super_admins)
  scope :private_access, -> { where access_state: :private }
  scope :public_access, -> { where access_state: :public }
  scope :super_admin_access, -> { where access_state: :super_admin }
  scope :drafts, -> { where state: :draft }
  scope :standards, -> { where state: :standard }

  def self.sort_standards_by_code(standards)
    standards.sort_by { |a| a.code.split('.').map &:to_i }
  end

  def node_numbers
    if (children.empty?)
      return [1]
    end
    all = children.order("number DESC")
    last_number = all.first.number + 1
    array = (1..last_number).to_a
    all.each do |one|
      array.delete(one.number)
    end
    return array
  end

  def self.root_numbers
    all = roots.order("number DESC")
    if all.empty?
      return [1]
    end
    last_number = all.first.number + 1
    array = (1..last_number).to_a
    all.each do |one|
      array.delete(one.number)
    end
    return array
  end

  def for_select
    ("-" * depth) + "#{code} #{name}"
  end

  def code
    ret = self.number.to_s
    temp = self
    while temp.parent
      temp = temp.parent
      ret = "#{temp.number.to_s}.#{ret}"
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
    all.each do |one|
      return one if one.link == link
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