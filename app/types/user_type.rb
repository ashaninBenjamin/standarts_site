class UserType < User
  include BaseType

  attr_accessible :login, :password, :role_id, :profile_id, :company_id, :password_confirmation

  validates :login, presence: true,
            length: {within: 3..15},
            format: {with: /\A[a-zA-Z0-9]+\z/},
            uniqueness: true
  validates :password, presence: true,
            confirmation: true,
            length: {within: 1..20}
  validates :role, presence: true

end