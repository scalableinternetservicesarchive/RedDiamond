class GroupsController < ApplicationController
    def index
        @groups = Group.all
    end

    def room
        # redirect_to edit_user_path(id: params[:username])
    end
end
