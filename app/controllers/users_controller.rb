class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!, :only => :destroy

  def show
    if User.exists? params[:id]
      @user = User.find(params[:id])
    else
      flash[:notice] = "Impossible de trouver la personne"
      redirect_to root_path
    end
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def destroy
    User.destroy(params[:id]) 
    flash[:notice] = "User destroyed"
    redirect_to user_index_path
  end

  def edit_avatar
  end
  def edit_cv
    @user = current_user
  end
  def edit_bateaux
  end

  private

  def authenticate_admin!
    if user_signed_in?
      unless current_user.admin?
        flash[:notice] = "You must be an admin to do that!"
        redirect_to root_path
      end
    end
  end
end
