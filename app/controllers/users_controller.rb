class UsersController < ApplicationController
  def edit
    @user = User.find_or_create_by(username: params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)

    redirect_to edit_user_path(id: @user.username)
  end

  private

  def user_params
    params.require(:user).permit(:bio)
  end
end
