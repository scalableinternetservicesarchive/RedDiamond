class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    filter = { game_id: params[:game_id] }
    params.each do |key, value|
      if key.end_with?("filter") && !params[key].nil? && params[key] != ""
        filter_name = key.delete_suffix("_filter")
        filter[filter_name] = value
      end
    end
    puts("DEBUG")
    puts(filter)
    @game = Game.find(params[:game_id])
    @groups = Group.where(filter)
    @filter = filter
    puts(filter)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @game = Game.find(params[:game_id])
  end

  # GET /groups/new
  def new
    @game = Game.find(params[:game_id])
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @game = @group.game
  end

  # POST /groups or /groups.json
  def create
    authenticate_user!

    @game = Game.find(params[:game_id])
    @group = @game.groups.create(group_params)
    @group.group_memberships.create(user: current_user, owner: true)

    respond_to do |format|
      if @group.save
        format.html { redirect_to game_group_url(@game, @group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    authenticate_user!

    game = Game.find(params[:game_id])
    group = Group.find(params[:id])

    return redirect_to game_group_url(game, group), notice: 'You are already a member of this group!' if group.members.exists?(current_user.id)
    return redirect_to game_group_url(game, group), notice: 'This group is already full' if group.members.size > group.max_member_count

    group.group_memberships.create(user: current_user, pending: true)

    redirect_to game_group_url(game, group), notice: "You have requested to join #{group.group_name}"
  end

  def approve
    authenticate_user!

    game = Game.find(params[:game_id])
    group = Group.find(params[:id])
    to_approve = User.find(params[:user_id])

    requester_membership = group.group_memberships.find_by(user: current_user)
    membership = group.group_memberships.find_by(user: to_approve)

    return redirect_to game_group_url(game, group), notice: 'You are not a member of this group' if requester_membership.nil? || requester_membership.pending?
    return redirect_to game_group_url(game, group), notice: 'This user has not requested to join this group' if membership.nil?
    return redirect_to game_group_url(game, group), notice: 'This user is already a member of this group' unless membership.pending?

    membership.update!(pending: false)

    redirect_to game_group_url(game, group), notice: "#{to_approve.username} is now a member of #{group.group_name}"
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    @game = @group.game
    respond_to do |format|
      if group_params[:join]
        if @group.current_member_count >= @group.max_member_count
          format.html { redirect_to game_group_url(@game, @group), notice: "You cannot join a full group!" }
        elsif @group.update(current_member_count: @group.current_member_count + 1)
          format.html { redirect_to game_group_url(@game, @group), notice: "Join success" }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      elsif @group.update(group_params)
        format.html { redirect_to game_group_url(@game, @group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    # @group.destroy
    @game = Game.find(@group.game_id)
    @game.groups.destroy(@group)
    respond_to do |format|
      format.html { redirect_to game_groups_url(@game), notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:group_name, :activity, :description, :leader_name, :max_member_count, :game_id, :join)
    end
end
