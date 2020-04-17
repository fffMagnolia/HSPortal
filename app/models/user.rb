class User < ApplicationRecord
  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 255 }, email: true, uniqueness: { case_sensitive: false }
  validates :password,                 length: { minimum: 8 }

  def email=(e)
    e = e.gsub(" ", "").downcase if e
    super
  end

  has_secure_password
end
