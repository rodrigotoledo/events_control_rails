# frozen_string_literal: true

Admin.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
user = User.create(name: Faker::Name.name_with_middle, email: 'user@example.com', uid: SecureRandom.uuid,
                   password: 'password', password_confirmation: 'password')

cover_path = Rails.root.join('db/event_cover.jpeg')

# Anexar os arquivos de imagens
image_1_path = Rails.root.join('db/events_01.jpeg')
image_2_path = Rails.root.join('db/events_02.jpeg')

2.times do
  event = Event.create(title: Faker::Esport.event, location: Faker::Address.full_address, display_location: true,
                       description: Faker::Lorem.paragraph, scheduled_at: Time.current + 10.days, confirmation_ends_at: Date.today + 10.days, active: true)
  event.cover.attach(io: File.open(cover_path), filename: File.basename(cover_path))
  event.images.attach(io: File.open(cover_path), filename: File.basename(cover_path))
  event.images.attach(io: File.open(image_1_path), filename: File.basename(image_1_path))
  event.images.attach(io: File.open(image_2_path), filename: File.basename(image_2_path))
  2.times do
    user = User.create(name: Faker::Name.name_with_middle, email: Faker::Internet.email,
                       uid: SecureRandom.uuid, password: 'password', password_confirmation: 'password')
    event.users << user
  end
end
