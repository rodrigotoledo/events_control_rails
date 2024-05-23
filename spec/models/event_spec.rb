# frozen_string_literal: true

# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { build(:event) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:scheduled_at) }
    it { should validate_presence_of(:confirmation_ends_at) }

    context 'when display_location is true' do
      it 'validates presence of location' do
        event.display_location = true
        event.location = nil
        event.valid?
        expect(event.errors[:location]).not_to be_empty
      end
    end
  end

  describe 'associations' do
    it { should have_one_attached(:cover) }
    it { should have_many_attached(:images) }
    it { should have_many(:event_users).dependent(:destroy) }
    it { should have_many(:users).through(:event_users) }
  end

  describe '#formatted_scheduled_at' do
    it 'returns the formatted scheduled_at' do
      event.scheduled_at = Time.zone.local(2023, 5, 21, 10, 0, 0)
      expect(event.formatted_scheduled_at).to eq(I18n.l(event.scheduled_at, format: :short))
    end
  end

  describe '#cover_image_url' do
    it 'returns the URL of the cover image if attached' do
      event.save!
      expect(event.cover_image_url).to be_present
    end

    it 'returns false if the cover image is not attached' do
      event.cover.detach
      expect(event.cover_image_url).to be_falsey
    end
  end

  describe '#images_url' do
    it 'returns empty when dont have images attached' do
      event_without_images = create(:event)
      event_without_images.cover.detach
      event_without_images.images.detach
      expect(event_without_images.images_url).to be_empty
    end
    it 'returns the URLs of all attached images' do
      event.save!
      urls = event.images_url
      expect(urls).to all(be_present)
      expect(urls.size).to eq(3)
    end
  end

  describe '#can_participate' do
    it 'returns true if the event is scheduled in the future' do
      event.scheduled_at = 1.day.from_now
      expect(event.can_participate).to be true
    end

    it 'returns false if the event is scheduled in the past' do
      event.scheduled_at = 1.day.ago
      expect(event.can_participate).to be false
    end
  end
end
