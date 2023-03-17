
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

number = [1, 2, 3, 4, 5]
# puts" destoying all ingredients"

# Ingredient.destroy_all

# puts "creating some ingredients"
# ingredients = []
# 100.times do
#   ingredients << Ingredient.create(name: Faker::Food.ingredient )
# end

# puts "done"

# puts "destroying all users and Reviews"
# Review.destroy_all
# User.destroy_all

puts "creating users"
users = []
# 5.times do
#   users << User.create(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: 123456,
#     user_name: Faker::FunnyName.name,
#     photo: PHOTOS.sample,
#     food_preferences: 3.times do
#       Faker::Food.dish
#     end,
#     allergies: 3.times do
#       Faker::Food.ingredient
#     end
#   )
# end
# users << User.create(first_name: "Miguel", last_name: "Gonçalves", email: Faker::Internet.email, password: 123456, user_name:"Mgoncalves97", photo: "https://avatars.githubusercontent.com/u/122788524?v=4")
# users << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::FunnyName.name, photo: "https://avatars.githubusercontent.com/u/34249168?v=4")
# users << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::FunnyName.name, photo: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1631269627/uyrtsrgexy7idwrlvr5k.jpg")
# users << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::FunnyName.name, photo: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1631269627/uyrtsrgexy7idwrlvr5k.jpg")
# users << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::FunnyName.name, photo: "https://avatars.githubusercontent.com/u/14589?v=4")
# users << User.create(first_name: "Miguel", last_name: "Figueiredo", email: Faker::Internet.email, password: 123456, user_name: "Sexy_Jesus", photo: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1673277208/ucy8m2c4kdppmnv9dkga.jpg")
# users << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::FunnyName.name, photo: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1673900496/s6nqcj4a04urtomwrywg.jpg")
# users << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::FunnyName.name, photo: "https://avatars.githubusercontent.com/u/122548090?v=4")
# puts "done"

require "json"
require "rest-client"
require 'byebug'

# puts "deleting all recipes"
# Recipe.destroy_all
# RecipeIngredient.destroy_all
# puts "creating recipes"

# 10.times do
#   recipe = Recipe.create(name: Faker::Food.dish, prep_time: [1..60].sample, description: Faker::Food.description, calories: [100..1000].sample, photo_url: Faker::LoremFlickr.image(size: "50x60", search_terms: ['food']))
#   10.times do
#     RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: ingredients.sample.id)
#   end
# end
# => repos is an `Array` of `Hashes`.
response1 = RestClient.get "https://api.spoonacular.com/recipes/findByIngredients?ingredients=spaghetti&number2&apiKey=#{ENV['SPOON_API_KEY']}"
repos = JSON.parse(response1)
# puts "destroying all ingredients and recipes"

# RecipeIngredient.destroy_all
# Recipe.destroy_all
# Ingredient.destroy_all
# puts "Creating recipes and Ingredients"

repos.each do |repo|
  response2 = RestClient.get "https://api.spoonacular.com/recipes/#{repo['id']}/information?includeNutrition=false&apiKey=#{ENV['SPOON_API_KEY']}"
  recipe_info = JSON.parse(response2)

  recipe_info["analyzedInstructions"].each do |el|
    el["steps"].each do |e|
      e["ingredients"].each do |element|
        unless unique_ingredient = Ingredient.find_by(name: element["name"])
          unique_ingredient = Ingredient.create(name: element["name"])
        end

        unless unique_recipe = Recipe.find_by(name: repo["title"])
          unique_recipe = Recipe.create(name: repo["title"], rating: repo["spoonacularScore"], photo_url: repo["image"], description: recipe_info["instructions"])
        end

        unless RecipeIngredient.find_by(recipe: unique_recipe, ingredient: unique_ingredient)
          RecipeIngredient.create(recipe: unique_recipe, ingredient: unique_ingredient)
        end
      end
    end
  end
end

# Recipe.all.each do |recipe|
#   users.shuffle.each do |user|
#     Review.create(comment: Faker::Marketing.buzzwords, rating: number.sample, user:, recipe:)
#   end
# end

puts "Created #{Recipe.count}recipes----#{Ingredient.count}ingredients"
puts "Created #{Review.count} reviews"

puts "Deleting Supermarkets"
Supermarket.destroy_all
puts "Creating Supermarkets"
Supermarket.create(address: "Avenida Duque de Loulé 77, lisboa", latitude: 38.7267915, longitude: -9.1465821, name: "Mini Preço")
Supermarket.create(address: "Rua Barata Salgueiro 70, lisboa", latitude: 38.7216796, longitude: -9.1477105, name: "Mini Preço")
Supermarket.create(address: "Avenida de Loulé 96, Lisboa", latitude: 38.7269309, longitude: -9.1468988, name: "Continente")
Supermarket.create(address: "Rua Gomes Freire 5, lisboa", latitude: 38.7241428, longitude: -9.1399506, name: "Continente")
Supermarket.create(address: "Rua Tomás Ribeiro 97, lisboa", latitude: 38.7316275, longitude: -9.1493437, name: "Pingo Doce")
Supermarket.create(address: "Largo do Mastro 29, lisboa", latitude: 38.7220171, longitude: -9.1391596, name: "Pingo Doce")
puts "Done"
