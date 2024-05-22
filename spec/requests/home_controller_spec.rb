# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'Home' do
    describe 'GET /' do
      it 'returns ok' do
        get root_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
