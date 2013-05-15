class UserSignInType
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Virtus

  attribute :login, String
  attribute :password, String

  validates :login, presence: true
  validates :password, presence: true

  validates_each :login do |record, attr, value|
    user = record.user

    if !user.try(:authenticate, record.password)
      record.errors.add(attr, :user_or_password_invalid)
    end
  end

  def persisted?
    false
  end

  def user
    @user ||= User.find_by_login(login)
  end

end