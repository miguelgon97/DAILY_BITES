class RecipesController < ApplicationController

  before_action :authenticate_user!, only: :toggle_favorite



  def index
    if params[:query].present?

      ingredient1 = Ingredient.where( name: "Chia Seeds")[0]
      ingredient2 = Ingredient.where( name: "Mangosteens")[0]
      ingredient3 = Ingredient.where( name: "Tangelo")[0]

      initial_array = ingredient1.recipes
      first_filter = initial_array.each do |recipe|
          recipe.recipe_ingredients.filter do |recipe_ingredient|
          recipe_ingredient.ingredient_id == ingredient2.id
        end
      end

       @recipes = first_filter.each do |recipe|
          recipe.recipe_ingredients.filter do |recipe_ingredient|
          recipe_ingredient.ingredient_id == ingredient3.id
        end
      end
    else
      @recipes = Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def toggle_favorite
    @recipe = Recipe.find_by(id: params[:id])
    current_user.favorited?(@recipe) ? current_user.unfavorite(@recipe) : current_user.favorite(@recipe)
    redirect_to profile_path, notice: "Favourited #{@recipe.name}"
  end
end
