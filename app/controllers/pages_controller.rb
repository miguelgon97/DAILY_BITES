class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    @user = current_user
    @recipes = Recipe.first(5)
    @ingredients_to_buy = Ingredient.includes(recipe_ingredients: :recipe).where(recipe_ingredients: { recipe_id: @recipes })
    @random_date = DateTime.now - (rand * 10950)
  end
end
