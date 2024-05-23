# frozen_string_literal: true

module Api
  class UsersController < Api::ApplicationController
    before_action :authenticate_user!, only: %i[update]

    def create
      user = User.new(user_params)
      if user.save
        token = login(user)
        render json: { user: user.attributes.except('password_digest'), token: token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      user = current_user
      if user.update(user_params)
        render json: { user: user.attributes.except('password_digest') }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      return {} unless params.key?(:user)

      params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone)
    end
  end
end
