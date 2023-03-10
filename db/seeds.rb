
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# puts" destoying all ingredients"

# Ingredient.destroy_all

# puts "creating some ingredients"
# ingredients = []
# 100.times do
#   ingredients << Ingredient.create(name: Faker::Food.ingredient )
# end

# puts "done"

# puts "destroying all users"

# User.destroy_all

# puts "creating users"

# 5.times do
#   User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: 123456, user_name: Faker::Internet.username)
# end

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
response1 = RestClient.get "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number2&apiKey=#{ENV['SPOON_API_KEY']}"
repos = JSON.parse(response1)


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
          unique_recipe = Recipe.create(name: repo["title"], rating: repo["spoonacularScore"], photo_url: repo["image"], description: recipe_info["instructions"], prep_time: recipe_info["preparationMinutes"])
        end

        unless RecipeIngredient.find_by(recipe: unique_recipe, ingredient: unique_ingredient)
          RecipeIngredient.create(recipe: unique_recipe, ingredient: unique_ingredient)
        end

      end
    end
  end
end

puts "Created #{Recipe.count}recipes----#{Ingredient.count}ingredients"


#   Recipe.create(
#     name: repo["title"],
#     rating: repo["spoonacularScore"],
#     photo_url: repo["image"],
#     description: recipe_info["instructions"],
#     prep_time: recipe_info["preparationMinutes"]
#   )

