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
    if params[:thumb]
      target.create(thumb_params)
      redirect_to redirect_target
    else
      redirect_to redirect_target, alert: "Please select one"
    end
  end

  private
  def thumb_params
    params.require(:thumb).permit(:value).merge(thumber: current_user)
  end
end
