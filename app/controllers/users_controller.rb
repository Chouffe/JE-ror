class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    if User.exists? params[:id]
      @user = User.find(params[:id])
    else
      flash[:notice] = "Impossible de trouver la personne"
      redirect_to root_path
    end
  end
end
