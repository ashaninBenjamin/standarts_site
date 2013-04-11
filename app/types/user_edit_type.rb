class UserEditType < User
  include BaseType

  attr_accessible :password_confirmation

  validates :login, presence: true,
            length: {within: 3..15},
            format: {with: /\A[a-zA-Z0-9]+\z/},
            uniqueness: true
  validates :password, presence: true,
            length: {within: 3..20}
  validates :role, presence: true

end