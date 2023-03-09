class RecipesController < ApplicationController
  before_action :authenticate_user!, only: :toggle_favorite

  def index
    @ingredients = Ingredient.all
    @selected_ingredient = Ingredient.first

    if params[:search].present?

      @selected_ingredient = params[:search][:ingredient]

      @recipes = Ingredient.find(@selected_ingredient).recipes

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
  end
end
