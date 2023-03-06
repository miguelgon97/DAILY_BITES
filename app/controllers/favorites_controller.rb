class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new(favorite_params)
  end

  private


  def favorite_params
    params.require(:favorite).permit(:user_id, :recipe_id)
  end

end
