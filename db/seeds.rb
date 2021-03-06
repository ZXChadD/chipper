# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

10.times do
  User.create(
    email: Faker::Internet.email,
    password: 123_456,
    username: Faker::Name.first_name,
    avatar: UiFaces.face
  )
end

20.times do
  Tweet.create(
    body: Faker::StarWars.quote,
    user_id: Faker::Number.between(1, 30)
  )
end
