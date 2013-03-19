require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :password_confirmation, :password, :email_confirmation
  attr_accessible :login, :password, :password_confirmation, :email, :email_confirmation

  before_save :create_token

  validates_uniqueness_of :login
  validates_presence_of :login
  validates_length_of :password_confirmation, :minimum => 5
  validates_presence_of :password
  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :email
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def password
    @pwd ||= BCrypt::Password.new(password_hash)
  end

  def password=(new)
    @pwd = BCrypt::Password.create(new)
    self.password_hash = @pwd
  end

  def authenticate(unencrypted)
    BCrypt::Password.new(password_hash) == unencrypted ? self : false
  end

  private

    def create_token
      self.token = SecureRandom.urlsafe_base64
    end

end
