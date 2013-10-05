class Admin < ActiveRecord::Base
  has_many :api_authorizations
  has_many :classrooms
  has_many :assignments
  attr_accessor :password
  before_save :encrypt_password

  validates :password, confirmation: true, presence: true, on: :create
  validates :username, uniqueness: true, presence: true
  scope :quizlet_auth, -> { includes(:api_authorizations).where('api_authorizations.name = ?', 'quizlet') }

  def authorized_quizlet
    return true if ApiAuthorization.where(name: 'quizlet', admin_id: self.id).count > 0
  end

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
