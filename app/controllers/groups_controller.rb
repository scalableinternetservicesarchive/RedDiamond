class GroupsController < ApplicationController
    def index
        @groups = Group.all
    end

    # def new
    # end

    def show #id
        # redirect_to edit_user_path(id: params[:username])
        puts "fetching group"
        @room = Group.find(params[:id])
    end
end
