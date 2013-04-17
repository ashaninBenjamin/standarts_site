#coding: utf-8
class User < ActiveRecord::Base

  attr_accessible :login, :password, :role_id, :profile_id, :company_id

  has_secure_password

  belongs_to :role
  belongs_to :profile, dependent: :destroy
  belongs_to :company, dependent: :destroy

  has_many :standards, dependent: :destroy
  has_many :session_histories, dependent: :destroy

  scope :super_admins, -> { where(role_id: Role.super_roles) }

  def correct?
    ((profile.present?) && (company.present?))
  end

  def super_admin?
    role.super_role?
  end

end
