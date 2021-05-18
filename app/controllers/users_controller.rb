class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if user_signed_in? && current_user == @user
      render :show
    else
      redirect_to root_path
    end
  end
end
