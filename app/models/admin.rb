class Admin < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates :password, confirmation: true, presence: true, on: :create
  validates :username, uniqueness: true, presence: true

  def self.authenticate(username, password)
    admin = find_by username: username
    if admin && admin.password_hash == BCrypt::Engine.hash_secret(password, admin.password_salt)
      admin
    else
      nil
    end
  end

  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
