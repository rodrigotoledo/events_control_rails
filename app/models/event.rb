# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :hostel
  has_one_attached :cover
  has_many_attached :images
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  validates :title, :description, :scheduled_at, :confirmation_ends_at, presence: true
  validates :location, presence: true, if: :display_location?

  def formatted_scheduled_at
    I18n.l(scheduled_at, format: :short) # Formate a data e hora usando I18n.l
  end

  def cover_image_url
    ActiveStorage::Current.url_options = { host: ENV['HOST_ATTACHMENTS_API'] }

    # Retorne a URL da imagem anexada
    cover.attached? ? cover.url : false
  end

  def can_participate
    scheduled_at && scheduled_at >= Time.current
  end

  private

  def display_location?
    display_location == true
  end
end
