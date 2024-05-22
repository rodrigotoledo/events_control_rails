# frozen_string_literal: true

# spec/factories/events.rb
FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    scheduled_at { Faker::Time.forward(days: 23, period: :morning) }
    confirmation_ends_at { Faker::Time.forward(days: 20, period: :evening) }
    location { Faker::Address.full_address }
    display_location { true }

    after(:build) do |event|
      event.cover.attach(
        io: File.open(Rails.root.join('db/event_cover.jpeg')),
        filename: 'event_cover.jpeg'
      )
      event.images.attach(
        io: File.open(Rails.root.join('db/events_01.jpeg')),
        filename: 'events_01.jpeg'
      )
      event.images.attach(
        io: File.open(Rails.root.join('db/events_01.jpeg')),
        filename: 'events_01.jpeg'
      )
    end
  end
end
