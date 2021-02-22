class CommentsController < ApplicationController 
    def create
        authenticate_user!

        @user = User.find_by_username(params[:profile_username])
        @comment = @user.comments.create(comment_params)
        redirect_to profile_path(@user)
    end
    
    private
        def comment_params
            params.require(:comment).permit(:body).merge(commenter: current_user)
        end
end
