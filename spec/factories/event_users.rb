# frozen_string_literal: true

# spec/factories/event_users.rb
FactoryBot.define do
  factory :event_user do
    association :event
    association :user
  end
end
