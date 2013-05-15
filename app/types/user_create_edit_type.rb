class UserCreateEditType < User
  include BaseType

  attr_accessible :password_confirmation

  validates :login, length: {within: 3..15},
            format: {with: /\A[a-zA-Z0-9]+\z/},
            uniqueness: true
  validates :password, length: {within: 3..20}

end