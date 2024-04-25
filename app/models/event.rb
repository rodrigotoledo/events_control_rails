class Event < ApplicationRecord
  has_one_attached :cover
  has_many_attached :images
  has_many :event_participants, dependent: :destroy
  has_many :participants, through: :event_participants
  validates :title, :description, :scheduled_at, :confirmation_ends_at, presence: true
end
