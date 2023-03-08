class RecipesController < ApplicationController

  before_action :authenticate_user!, only: :toggle_favorite



  def index
    @recipes = Recipe.all
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
