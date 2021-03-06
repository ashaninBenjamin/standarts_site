# coding: utf-8
class Standard < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :content, :name, :number, :user_id, :parent_id, :state, :access_state, :access_state_event

  has_ancestry
  belongs_to :user

  validates :name, presence: true
  validates :number, presence: true
  validates :user, presence: true

  validates_each :number do |record, attr, value|
    if record.new_record?
      if record.siblings.where(number: value).present?
        record.errors.add(attr, :taken)
      end
    else
      if record.siblings.where("id not IN (?) AND number IN (?)", record.id, value).present?
        record.errors.add(attr, :taken)
      end
    end
  end

  def refrain_children
    children.each { |one| one.keep }
  end

  state_machine :state, initial: :refrained do
    state :published
    state :refrained

    after_transition on: :refrain, do: :refrain_children

    event :refrain do
      transition all => :refrained
    end

    event :publish do
      transition all => :published
    end

  end

  state_machine :access_state, initial: :private do
    state :private
    state :public

    event :hide do
      transition all => :private
    end

    event :show do
      transition all => :public
    end
  end

  before_update :check_content

  scope :all_by_super_admin, -> { scoped_by_user_id(User.super_admins) }

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