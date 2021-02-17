class GroupsController < ApplicationController
    def index
        @groups = Group.all
    end

    def create 
        name = params[:group_name]
        max_count = params[:max_member_count]
        # TODO: may need to change
        @group = Group.find_or_create_by(group_name: name, max_member_count: max_count)
    end

    def show #id
        # redirect_to edit_user_path(id: params[:username])
        puts "fetching group"
        @room = Group.find(params[:id])
    end
end
