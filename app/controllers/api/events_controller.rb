# frozen_string_literal: true

module Api
  class EventsController < Api::ApplicationController
    before_action :authenticate_user!

    def index
      events = Event.order(scheduled_at: :desc).to_json(methods: %i[formatted_scheduled_at cover_image_url
                                                                    can_participate])
      render json: { events: events }
    end

    def show
      event = Event.find(params[:id])
      render json: {
        event: event.to_json(methods: %i[formatted_scheduled_at cover_image_url can_participate]),
        user_event_ids: current_user.event_ids
      }
    rescue StandardError => e
      logger.info e.message
      head :unprocessable_entity
    end

    def toggle_activation
      if current_user.event_ids.include?(params[:event_id])
        current_user.event_users.where(event_id: params[:event_id]).first.destroy!
      else
        current_user.events << Event.find(params[:event_id])
      end
      head :ok
    rescue StandardError => e
      logger.info e.message
      head :unprocessable_entity
    end
  end
end
