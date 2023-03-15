class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @random_date = DateTime.now - (rand * 10950)
  end
end
