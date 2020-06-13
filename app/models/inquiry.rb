class Inquiry < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :message, presence: true, length: { maximum: 500 } 
end