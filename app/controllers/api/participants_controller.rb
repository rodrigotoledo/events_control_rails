# frozen_string_literal: true

module Api
  class ParticipantsController < Api::ApplicationController
    before_action :authenticate_participant!, only: :update

    def create
      participant = Participant.new(participant_params)
      if participant.save
        token = login(participant)
        render json: { participant: participant.attributes.except("password_digest"), token: token }, status: :created
      else
        render json: { errors: participant.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      participant = current_participant
      if participant.update(participant_params)
        render json: { participant: participant.attributes.except("password_digest") }, status: :ok
      else
        render json: { errors: participant.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def participant_params
      return {} unless params.key?(:participant)

      params.require(:participant).permit(:email, :password, :password_confirmation, :name, :phone)
    end
  end
end
