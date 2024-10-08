# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    name { Faker::Name.name_with_middle }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
  end
end
