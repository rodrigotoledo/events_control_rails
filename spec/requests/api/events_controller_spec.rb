# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Events', type: :request do
  describe 'Events Operations' do
    describe 'GET /events' do
      let!(:user) { create(:user) }
      before do
        create_list(:event, 5)
      end
      it 'returns a list of events in ascending order of creation' do
        get api_events_path, headers: generate_jwt_token(user)
        events = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(events.length).to eq(5)
      end
    end

    describe 'GET /events/:id' do
      let!(:user) { create(:user) }
      let!(:event) { create(:event) }
      before do
        user.events << event
      end

      it 'returns the event details' do
        get api_event_path(event), headers: generate_jwt_token(user)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        event_json = JSON.parse(json_response[:event], symbolize_names: true)

        expect(event_json[:title]).to eq(event.title)
        expect(event_json[:description]).to eq(event.description)
        expect(event_json[:formatted_scheduled_at]).to be_present
        expect(event_json[:images_url]).to be_present
        expect(event_json[:cover_image_url]).to be_present
        expect(event_json[:can_participate]).to eq(event.can_participate)
        expect(json_response[:user_event_ids]).to include(event.id)
      end

      it 'returns invalid event' do
        get api_event_path(-123), headers: generate_jwt_token(user)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'events/toggle_activation' do
      let(:user) { create(:user) }
      describe 'PATCH /events/toggle_activation' do
        it 'toggle_activation add user to event' do
          event = create(:event)

          patch toggle_activation_api_event_path(event.id), headers: generate_jwt_token(user)
          user.reload

          expect(response).to have_http_status(:ok)
          expect(user.event_ids).to include(event.id)
        end

        it 'toggle_activation event remove user from event' do
          event_one = create(:event)
          event_two = create(:event)
          user.events << event_one
          user.events << event_two
          user.save!

          patch toggle_activation_api_event_path(event_one.id), headers: generate_jwt_token(user)
          user.reload

          expect(response).to have_http_status(:ok)
          expect(user.event_ids).not_to include(event_one.id)
          expect(user.event_ids).to include(event_two.id)
        end

        it 'returns invalid event' do
          patch toggle_activation_api_event_path(-123), headers: generate_jwt_token(user)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
