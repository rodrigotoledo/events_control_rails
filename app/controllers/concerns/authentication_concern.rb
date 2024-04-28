# frozen_string_literal: true

module AuthenticationConcern
  extend ActiveSupport::Concern

  def encode_token(payload)
    JWT.encode(payload, ENV.fetch("JWT_KEY"))
  end

  def decode_token
    auth_header = request.headers["Authorization"]
    return unless auth_header

    begin
      token = auth_header.split(" ").last
      JWT.decode(token, ENV.fetch("JWT_KEY"), true, algorithm: "HS256")
    rescue StandardError => e
      logger.info "==== error on decode_token"
      logger.info e.message
      logger.info "===="
      head :unauthorized
    end
  end

  protected

  # use with before_action to authorize access
  def authenticate_participant!
    head :unauthorized unless participant_sign_in?
  end

  def current_participant
    decoded_token_info = decode_token
    return unless decoded_token_info

    begin
      participant_id = decoded_token_info.first["participant_id"]
      participant = Participant.find(participant_id)
      Current.participant ||= participant
    rescue StandardError => e
      logger.info "==== error on current_participant"
      logger.info e.message
      logger.info "===="
      nil
    end
  end

  def participant_sign_in?
    current_participant.present?
  end

  def login(participant)
    Current.participant = participant
    reset_session
    encode_token({ participant_id: participant.id })
  end

  def logout(_participant)
    Current.participant = nil
    encode_token({ participant_id: Faker::Internet.password })
    reset_session
  end
end
