class Info < ApplicationRecord
  # イベント削除時に同時に削除される
  belongs_to :event

  validates :message,  presence: true, length: { maximum: 1000 }
  validates :event_id, presence: true
end
