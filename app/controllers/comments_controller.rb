class CommentsController < ApplicationController
  def create
    authenticate_user!

    if params[:profile_username].present?
      user = User.find_by_username(params[:profile_username])
      target = user.comments
      redirect_target = profile_url(user)
    elsif params[:group_id].present?
      group = Group.find(params[:group_id])
      target = group.comments
      redirect_target = game_group_url(group.game_id, group)
    else
      return head :unprocessable_entity
    end
    p '!!!!!!', comment_params
    target.create(comment_params)

    redirect_to redirect_target
  end

  private
  def comment_params
    params.require(:comment).permit(:body).merge(commenter: current_user)
  end
end
