class UserSignInType < User
  include BaseType

  validates :login, presence: true
  validates :password, presence: true

  def user
    @user ||= User.find_by_login(login)
  end

end