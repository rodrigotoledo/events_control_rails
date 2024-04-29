# frozen_string_literal: true

module Api
  class EventsController < Api::ApplicationController
    before_action :authenticate_participant!

    def index
      events = Event.order(scheduled_at: :desc).to_json(methods: %i[formatted_scheduled_at cover_image_url
                                                                    can_participate])
      render json: { events: events, participant_event_ids: current_participant.event_ids }
    end

    def toggle_activation
      if current_participant.event_ids.include?(params[:event_id])
        current_participant.event_participants.where(event_id: params[:event_id]).first.destroy!
      else
        current_participant.events << Event.find(params[:event_id])
      end
      head :ok
    rescue StandardError => e
      logger.info e.message
      head :unprocessable_entity
    end
  end
end
