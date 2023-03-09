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
