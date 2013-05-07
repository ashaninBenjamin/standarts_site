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
    if record.number
      if record.number.nonzero?
        if record.siblings.exclude(record).with(number: value).any?
          record.errors.add(attr, :taken)
        end
      else
        if record.siblings.exclude(record).with(user_id: record.user_id).any?
          record.errors.add(attr, :taken)
        end
      end
    end
  end

  before_save :set_root
  before_save :set_link

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
    all = with(number: 0).first.children.by_number
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

  def code
    link.gsub("-", ".")
  end

  private

  def set_root
    return if number.zero?
    self.parent = user.standards.with(number: 0).first unless parent
  end

  def set_link
    if parent && parent.number.nonzero?
      #FIXME! При изменении наследования возможно неправильное сохранение ссылки
      self.link = "#{parent.link}-#{number}"
    else
      self.link = number.to_s
    end
  end

end