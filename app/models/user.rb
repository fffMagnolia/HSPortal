class User < ApplicationRecord
  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 255 }, email: true, uniqueness: { case_sensitive: false }
  validates :password,                 length: { minimum: 8 }

  has_secure_password

  def email=(e)
    e = e.gsub(" ", "").downcase if e
    super
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end
end
