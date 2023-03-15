class RecipesController < ApplicationController
  before_action :authenticate_user!, only: :toggle_favorite

  def index
    @ingredients = Ingredient.all
    @selected_ingredient = Ingredient.first

    if params[:search].present?
      @recipes = Recipe.includes(recipe_ingredients: :ingredient).where(recipe_ingredients: { ingredient_id: params[:search][:ingredient] })

    else
      @recipes = Recipe.all
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @review = Review.new
    @reviews = Review.where(recipe: @recipe)
  end

  def toggle_favorite
    @recipe = Recipe.find_by(id: params[:id])
    current_user.favorited?(@recipe) ? current_user.unfavorite(@recipe) : current_user.favorite(@recipe)

    respond_to do |format|
      format.html { flash[:notice] = "Favorited #{@recipe.name}" }
      format.text { render partial: "shared/favorite-icon", locals: { recipe: @recipe }, formats: [:html] }
    end
  end

  private

  def review_params
    params.require(:reviews).permit(:comment, :rating)
  end
end
