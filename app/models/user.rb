#coding: utf-8
class User < ActiveRecord::Base
  include UserRepository

  attr_accessible :login, :password, :role_id, :profile_id, :company_id

  belongs_to :role
  belongs_to :profile, dependent: :destroy
  belongs_to :company, dependent: :destroy

  has_many :standards, dependent: :destroy
  has_many :session_histories, dependent: :destroy

  has_secure_password

  def correct?
    ((profile.present?) && (company.present?))
  end

  def super_admin?
    role.super_role?
  end

end
