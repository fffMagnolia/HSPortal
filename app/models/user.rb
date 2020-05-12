class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  before_create :create_activation_digest

  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 255 }, email: true, uniqueness: { case_sensitive: false }
  validates :password,                 length: { minimum: 8, allow_nil: true }

  has_secure_password

  def email=(e)
    e = e.gsub(" ", "").downcase if e
    super
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # token -> digest
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # tokenとdigestが一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # DBの永続セッション情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
