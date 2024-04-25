User.create(email: 'email@example.com', password: 'password', password_confirmation: 'password')
User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')

10.times do
  event = Event.create(title: Faker::Esport.event, location: Faker::Address.full_address, description: Faker::Lorem.paragraph, scheduled_at: Time.now+10.days, confirmation_ends_at: Date.today+10.days, active: true)
  10.times do
    participant = Participant.create(name: Faker::Name.name_with_middle, email: Faker::Internet.email, uid: SecureRandom.uuid)
    event.participants << participant
  end
end
