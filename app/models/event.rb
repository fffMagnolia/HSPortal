class Event < ApplicationRecord
  belongs_to :user
  has_many :entries, class_name: 'Entry', foreign_key: 'event_id', dependent: :destroy
  has_many :members, through: :entries, source: :user, dependent: :destroy
  has_many :infos, dependent: :destroy

  default_scope -> { order(start_date: :desc) }
    
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
