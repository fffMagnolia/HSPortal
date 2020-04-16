class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  # validationはemail_validatorで行っている
  validates :email, presence: true, length: { maximum: 255 }, email: true, uniqueness: true
end
