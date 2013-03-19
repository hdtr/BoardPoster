require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :password_confirmation, :password
  attr_accessible :login, :password, :password_confirmation

  before_save :create_token

  validates_uniqueness_of :login
  validates_presence_of :login
  validates_length_of :password_confirmation, :minimum => 5
  validates_presence_of :password
  validates_confirmation_of :password



  def password
    @pwd ||= BCrypt::Password.new(password_hash)
  end

  def password=(new)
    @pwd = BCrypt::Password.create(new)
    self.password_hash = @pwd
  end

  def authenticate(unencrypted)
  if BCrypt::Password.new(password_hash) == unencrypted
    self
  else
    false
  end
end

  private

    def create_token
      self.token = SecureRandom.urlsafe_base64
    end

end
