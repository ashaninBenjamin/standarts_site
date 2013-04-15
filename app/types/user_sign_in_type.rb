class UserSignInType < User
  include ActiveModel::Validations
  include BaseType

  validates :login, presence: true
  validates :password, presence: true

  validates_each :login do |record, attr, value|
    user = record.user

    if !user.try(:authenticate, record.password)
      record.errors.add(attr, :user_or_password_invalid)
    end
  end

  def user
    @user ||= User.find_by_login(login)
  end

end