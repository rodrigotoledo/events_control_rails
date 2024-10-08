# frozen_string_literal: true

# spec/factories/admins.rb
FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
