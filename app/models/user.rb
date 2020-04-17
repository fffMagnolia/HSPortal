class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, email: true, uniqueness: { case_sensitive: false }

  def email=(e)
    e = e.gsub(" ", "").downcase if e
    super
  end
end
