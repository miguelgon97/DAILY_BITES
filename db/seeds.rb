# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts" destoying all ingredients"

Ingredient.destroy_all

puts "creating some ingredients"

10.times do
  Ingredient.create(name: Faker::Food.ingredient )
end
puts "done"

puts "destroying all users"

User.destroy_all

puts "creating users"

5.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::Internet.username)
end

puts "destroying all recipes"

Recipe.destroy_all

puts "creating recipes"

10.times do
  Recipe.create(name:Faker::Food.dish, description: Faker::Food.description)
end
