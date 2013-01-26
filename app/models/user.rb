class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :login, :password, :roles_id, :user_info_id, :password_confirmation

  belongs_to :role, :primary_key => "id", :foreign_key => "roles_id"
  belongs_to :user_info, :primary_key => "id", :foreign_key => "user_info_id"

  validates :login, :presence => true,
            :length => {:within => 3..15}
  validates :password, :presence => true,
            :confirmation => :password == :password_confirmation,
            :length => {:within => 1..20}

  before_save :encrypt_password

  def has_password?(submitted_password)
    en_password == encrypt(submitted_password)
  end

  def self.authenticate(login, submitted_password)
    user = self.find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def super_admin?
    (self.role.name.eql?("super")) ? true : false
  end

  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.en_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{en_password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
