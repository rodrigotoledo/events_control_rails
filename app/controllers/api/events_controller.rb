# frozen_string_literal: true

module Api
  class EventsController < Api::ApplicationController
    before_action :authenticate_user!

    def index
      events = Event.order(scheduled_at: :desc).to_json(methods: %i[formatted_scheduled_at cover_image_url
                                                                    can_participate])
      render json: events
    end

    def show
      event = Event.find(params[:id])
      render json: event.to_json(methods: %i[formatted_scheduled_at cover_image_url can_participate images_url])
    rescue StandardError => e
      logger.info e.message
      head :unprocessable_entity
    end

    def toggle_activation
      if current_user.event_ids.include?(params[:id].to_i)
        current_user.event_users.where(event_id: params[:id]).destroy_all
      else
        current_user.events << Event.find(params[:id])
      end
      head :ok
    rescue StandardError => e
      logger.info e.message
      head :unprocessable_entity
    end
  end
end
