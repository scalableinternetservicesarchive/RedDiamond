class ThumbsController < ApplicationController
  def create
    authenticate_user!

    if params[:profile_username].present?
      user = User.find_by_username(params[:profile_username])
      target = user.thumbs
      redirect_target = profile_url(user)
    else
      return head :unprocessable_entity
    end
    p '!!!!!!!!!!', thumb_params
    p '***********', thumb_params[:thumber][:username]
    target.create(thumb_params)

    redirect_to redirect_target
  end

  private
  def thumb_params
    params.require(:thumb).permit(:body).merge(thumber: current_user)
  end
end
