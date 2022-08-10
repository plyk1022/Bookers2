class UsersController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = User.update(user_params)
    redirect_to books_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
