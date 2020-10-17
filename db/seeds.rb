# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do
  User.create(username: Faker::Internet.username)
end

3.times do
  Team.create(name: Faker::Internet.username)
end

3.times do
  Stock.create(name: Faker::Internet.username)
end