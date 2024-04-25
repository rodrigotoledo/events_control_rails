class Api::EventsController < ApplicationController
  def index
    render json: Event.order(:scheduled_at).to_json
  end

  def add_participant
    participant = Participant.find_by_uid(params[:uid])
    if participant.nil?
      head :unprocessable_entity
    else
      if @event.participants.include?(participant)
        head :ok
      else
        @event.participants << participant
        head :ok
      end
    end
  rescue => e
    head :unprocessable_entity
  end

  def remove_participant
    participant = Participant.find_by_uid(params[:uid])
    if participant.nil? || !@event.participants.include?(participant)
      head :unprocessable_entity
    else
      @event.participants.delete(participant)
      head :ok
    end
  rescue => e
    head :unprocessable_entity
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
