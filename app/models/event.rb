# frozen_string_literal: true

class Event < ApplicationRecord
  has_one_attached :cover
  has_many_attached :images
  has_many :event_participants, dependent: :destroy
  has_many :participants, through: :event_participants
  validates :title, :description, :scheduled_at, :confirmation_ends_at, presence: true

  def formatted_scheduled_at
    I18n.l(scheduled_at, format: :short) # Formate a data e hora usando I18n.l
  end

  def cover_image_url
    ActiveStorage::Current.url_options = { host: "a529-45-71-76-107.ngrok-free.app" }

    # Retorne a URL da imagem anexada
    cover.attached? ? cover.url : false
  end

  def can_participate
    scheduled_at && scheduled_at >= Time.current
  end
end
