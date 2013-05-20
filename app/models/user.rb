#coding: utf-8
class User < ActiveRecord::Base
  include UserRepository

  attr_accessible :login, :password, :password_confirmation

  validates :login, presence: true,
            length: {within: 3..15},
            format: {with: /\A[a-zA-Z0-9]+\z/},
            uniqueness: true
  validates :password, presence: true,
            length: {within: 3..20}
  validates :role, presence: true

  belongs_to :role
  belongs_to :profile, dependent: :destroy
  belongs_to :company, dependent: :destroy

  has_many :standards, dependent: :destroy
  has_many :session_histories, dependent: :destroy

  has_secure_password

  after_create :add_root

  def correct?
    ((profile.present?) && (company.present?))
  end

  def super_admin?
    role.super_role?
  end

  def to_s
    login
  end

  private

  def add_root
    root = standards.build(name: "root", number: 0)
    root.save
  end

end
