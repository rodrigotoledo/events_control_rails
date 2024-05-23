# frozen_string_literal: true

module Api
  class EventsController < Api::ApplicationController
    before_action :authenticate_user!
    before_action :find_event, only: :show

    def index
      events = Event.order(scheduled_at: :desc).to_json(methods: %i[formatted_scheduled_at cover_image_url
                                                                    can_participate])
      render json: events
    end

    def show
      render json: @event.as_json(methods: %i[formatted_scheduled_at cover_image_url can_participate
                                              images_url]).merge(in_event: @event.user_ids.include?(current_user.id))
    end

    def toggle_activation
      if current_user.event_ids.include?(params[:id].to_i)
        current_user.event_users.where(event_id: params[:id]).destroy_all
      else
        current_user.events << Event.find(params[:id])
      end
      head :ok
    rescue StandardError => e
      logger.error e.message
      head :unprocessable_entity
    end

    private

    def find_event
      @event = Event.find(params[:id])
    rescue StandardError => e
      logger.error e.message
      head :unprocessable_entity
    end
  end
end
