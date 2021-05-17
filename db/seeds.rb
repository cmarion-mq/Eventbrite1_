# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Event.destroy_all
Attendance.destroy_all

Faker::Config.locale = 'fr'

20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    email: Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: ['.']) + '@yopmail.com',
    first_name: first_name,
    last_name: last_name,
    encrypted_password: Faker::Internet.password,
    description: Faker::Lorem.sentences(number: 5).join(' ')
  )
end

5.times do
  Event.create(
    start_date: Time.now + rand(3..30).days,
    title: Faker::Lorem.sentence(word_count: 5),
    description: Faker::Lorem.sentences(number: 20).join(' '),
    duration: rand(1..1000) * 5,
    price: rand(1..1000),
    location: Faker::Address.city,
    administrator: User.all.sample
  )
end

15.times do
  Attendance.create(
    event: Event.all.sample,
    attendee: User.all.sample
  )
end