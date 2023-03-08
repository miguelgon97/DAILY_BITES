class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

end


# create an empty array with the ingredients picked by the user  @my_ingredients = []
# Connect the search to the recipes index to search by ingredient
# save the user choices
# show the most used ingredients on the profile

# Create a way to grab the user favorite ingredients on the recipe controller

# create a way to search for ingredients on the recipe index
