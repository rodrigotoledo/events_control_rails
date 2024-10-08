# frozen_string_literal: true

module AuthenticationConcern
  extend ActiveSupport::Concern

  def encode_token(payload)
    JWT.encode(payload, ENV.fetch('JWT_KEY'))
  end

  def decode_token
    auth_header = request.headers['Authorization']
    return unless auth_header

    begin
      token = auth_header.split(' ').last
      JWT.decode(token, ENV.fetch('JWT_KEY'), true, algorithm: 'HS256')
    rescue StandardError => e
      logger.info '==== error on decode_token'
      logger.info e.message
      logger.info '===='
      head :unauthorized
    end
  end

  protected

  # use with before_action to authorize access
  def authenticate_user!
    head :unauthorized unless user_sign_in?
  end

  def current_user
    decoded_token_info = decode_token
    return unless decoded_token_info

    begin
      user_id = decoded_token_info.first['user_id']
      user = User.find(user_id)
      Current.user ||= user
    rescue StandardError => e
      logger.info '==== error on current_user'
      logger.info e.message
      logger.info '===='
      nil
    end
  end

  def user_sign_in?
    current_user.present?
  end

  def login(user)
    Current.user = user
    reset_session
    encode_token({ user_id: user.id })
  end

  def logout(_user)
    Current.user = nil
    encode_token({ user_id: Faker::Internet.password })
    reset_session
  end
end
