
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
ingredients = []
 100.times do
    ingredients << Ingredient.create(name: Faker::Food.ingredient )
  end

puts "done"

puts "destroying all users"

User.destroy_all

puts "creating users"

5.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::Internet.username)
end

require "json"
require "rest-client"
require 'byebug'

Recipe.destroy_all

# => repos is an `Array` of `Hashes`.
response1 = RestClient.get "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number2&apiKey=#{ENV['SPOON_API_KEY']}"
repos = JSON.parse(response1)

p repos
repos.each do |repo|
  response2 = RestClient.get "https://api.spoonacular.com/recipes/#{repo['id']}/information?includeNutrition=false&apiKey=#{ENV['SPOON_API_KEY']}"
  recipe_info = JSON.parse(response2)

  Recipe.create(
    name: repo["title"],
    rating: repo["spoonacularScore"],
    photo_url: repo["image"],
    description: recipe_info["instructions"],
    prep_time: recipe_info["preparationMinutes"]
  )
end
