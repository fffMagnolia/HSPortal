class User < ApplicationRecord
  has_many :events, dependent: :destroy
  # user->entry
  has_many :members, class_name: 'Entry', foreign_key: 'user_id', dependent: :destroy
  # entry->user
  has_many :entries, through: :members, source: 'event'

  attr_accessor :remember_token, :activation_token, :reset_token

  before_create :create_activation_digest

  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 255 }, email: true, uniqueness: { case_sensitive: false }
  validates :password,                 length: { minimum: 8, allow_nil: true }
  validates :message,                  length: { maximum: 1000, allo_nil: true }

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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # DBの永続セッション情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_send_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_expired?
    reset_send_at < 30.minutes.ago
  end

  def entry(event)
    entries << event
  end

  def entry?(event)
    entries.include?(event)
  end

  def entry_possible?(event)
    # 以前に参加予約をしていない
    !current_user.entry?(event)
    # 主催者ではない（ビュー側で選別されているのでコメントで表記するのみ）
    !owner?(event)
    # 開始時刻1時間前以前である
    entry_limit = event.start_date - 1.hours
    entry_limit > Time.zone.now
    # 定員数に達していない
    event.entries.count <= event.capacity
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
