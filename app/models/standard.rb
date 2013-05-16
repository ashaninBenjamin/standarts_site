# coding: utf-8
class Standard < ActiveRecord::Base
  include StandardRepository
  attr_accessible :content, :name, :number, :user_id, :parent_id, :state, :access_state, :access_state_event

  belongs_to :user
  has_ancestry

  validates :name, presence: true
  validates :number, presence: true, unique_number: true
  validates :user, presence: true

  before_save :set_root

  state_machine :state, initial: :refrained do
    state :published
    state :refrained

    after_transition on: :refrain do |standard, transition|
      standard.descendants.each { |one| one.refrain }
      standard.descendants.each { |one| one.hide }
    end

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

  def self.sort_standards_by_code(standards)
    standards.sort_by { |a| a.code.split('.').map &:to_i }
  end

  def node_numbers
    if (children.empty?)
      return [1]
    end
    sorted_children = children.by_number
    last_number = sorted_children.first.number + 1
    array = (1..last_number).to_a
    sorted_children.each do |one|
      array.delete(one.number)
    end
    array
  end

  def code
    code = number.to_s
    temp = self
    while temp.parent && temp.parent.number.nonzero?
      temp = temp.parent
      code = "#{temp.number}.#{code}"
    end
    code
  end

  def link
    code.gsub(".", "-")
  end

  def available_number
    sorted_children = children.by_number
    if sorted_children.any?
      sorted_children.first.number + 1
    else
      1
    end
  end

  def to_s
    name
  end

  private

  def set_root
    return if number.zero?
    self.parent = user.standards.roots.first unless parent_id
  end

end