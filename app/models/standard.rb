# coding: utf-8
class Standard < ActiveRecord::Base
  include ActiveModel::Validations
  include StandardRepository
  attr_accessible :content, :name, :number, :user_id, :parent_id, :state, :access_state, :access_state_event, :link

  belongs_to :user
  has_ancestry

  validates :name, presence: true
  validates :number, presence: true
  validates :user, presence: true

  validates_each :number do |record, attr, value|
    if record.new_record?
      if record.siblings.with(number: value).present?
        record.errors.add(attr, :taken)
      end
    else
      if record.siblings.exclude(record.id).with(number: value).present?
        record.errors.add(attr, :taken)
      end
    end
  end

  state_machine :state, initial: :refrained do
    state :published
    state :refrained

    after_transition on: :refrain do |standard, transition|
      standard.descendants.each { |one| one.refrain }
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

  def self.root_numbers
    all = roots.by_number
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

  def node_numbers
    if (children.empty?)
      return [1]
    end
    all = children.by_number
    last_number = all.first.number + 1
    array = (1..last_number).to_a
    all.each do |one|
      array.delete(one.number)
    end
    return array
  end

end