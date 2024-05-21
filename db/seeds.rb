# frozen_string_literal: true

Admin.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
user = User.create(name: Faker::Name.name_with_middle, email: 'user@example.com', uid: SecureRandom.uuid,
                   password: 'password', password_confirmation: 'password')
2.times do
  event = Event.create(title: Faker::Esport.event, location: Faker::Address.full_address,
                       description: Faker::Lorem.paragraph, scheduled_at: Time.current + 10.days, confirmation_ends_at: Date.today + 10.days, active: true)
  2.times do
    user = User.create(name: Faker::Name.name_with_middle, email: Faker::Internet.email,
                       uid: SecureRandom.uuid, password: 'password', password_confirmation: 'password')
    event.users << user
  end
end
