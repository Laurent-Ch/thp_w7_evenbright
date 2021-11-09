# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

#configuration française
Faker::Config.locale = 'fr'

#supprimer les bases

User.destroy_all
Event.destroy_all
Attendance.destroy_all

#remplir table users

20.times do
user = User.create!(
  first_name: Faker::Name.name,
  last_name: Faker::Name.last_name,
  description: Faker::ChuckNorris.fact,
  email: Faker::Internet.email(domain: 'yopmail.com'),
  password: Faker::Alphanumeric.alphanumeric(number: 10)
  )
end

#remplir table event

30.times do
event = Event.create!(
  start_date: Faker::Date.forward(days: 365),
  duration: rand(1..10)*5,
  description: Faker::Quotes::Shakespeare.hamlet_quote,
  title: Faker::Lorem.characters(number: 10, min_alpha: 6),
  price: rand(1..1000),
  location: Faker::Address.street_address,
  host: User.all.sample(1).first
  )
end

#remplir table attendance

40.times do
  attendance = Attendance.create!(
    stripe_customer_id: Faker::Games::Pokemon.unique.name,
    guest: User.all.sample(1).first,
    event: Event.all.sample(1).first
    )
end