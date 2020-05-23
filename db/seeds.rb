# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: "Alice in Wonderland",
  email: "alice@example.com",
  message: Faker::ChuckNorris.fact,
  password: 'foobarbaz',
  password_confirmation: 'foobarbaz',
  activated: true,
  activated_at: Time.zone.now
)

user = User.first
10.times do |n|
  content = Faker::Dessert.variety
  r = Random.new
  random_time = Time.zone.now + r.rand(24*60*60)
  user.events.create!(content: content, start_date: random_time, end_date: Time.zone.now, title: "New Event #{n+1}") 
end