module Api
  class SessionsController < Api::ApplicationController
    before_action :authenticate_participant!, only: :destroy

    def create
      participant = Participant.find_by(email: params[:email])
      if participant&.authenticate(params[:password])
        token = login(participant)
        render json: { participant: participant.attributes.except("password_digest"), token: token }, status: :created
      else
        head :unprocessable_entity
      end
    end

    def forgot_password
      participant = Participant.find_by(email: params[:email])
      if participant&.reset_password
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def destroy
      logout current_participant
      head :no_content
    end
  end
end
