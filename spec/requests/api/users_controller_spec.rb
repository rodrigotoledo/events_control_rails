# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  let(:valid_params) do
    {
      user: attributes_for(:user)
    }
  end
  let!(:invalid_params) do
    {
      user: attributes_for(:user, name: '', email: 'invalid-email')
    }
  end
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post api_users_path, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'returns a JSON response with the new user' do
        post api_users_path, params: valid_params
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('user')
        expect(json_response).to have_key('token')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post api_users_path, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'returns a JSON response with errors' do
        post api_users_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/users' do
    let!(:user) { create(:user) }
    context 'with valid parameters' do
      it 'updates the user' do
        put api_user_path(user), params: valid_params, headers: generate_jwt_token(user)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:user][:email]).to eq(valid_params[:user][:email])
        expect(json_response[:user][:name]).to eq(valid_params[:user][:name])
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity' do
        put api_user_path(user), params: invalid_params, headers: generate_jwt_token(user)

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors].size).to eql(2)
      end
    end
  end
end
