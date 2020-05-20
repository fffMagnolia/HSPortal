class Event < ApplicationRecord
  belongs_to :user

  default_scope -> { order(start_date: :desc) }
    
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
