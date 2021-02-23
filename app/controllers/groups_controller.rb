class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @game = Game.find(params[:game_id])
    @groups = Group.where(game_id: params[:game_id])
  end

  # GET /groups/1 or /groups/1.json
  def show
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
    @game = Game.find(params[:game_id])
    @group = @game.groups.create(group_params)

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

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    @game = @group.game
    respond_to do |format|
      if @group.update(group_params)
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
      params.require(:group).permit(:group_name, :activity, :description, :leader_name, :max_member_count, :current_member_count, :game_id)
    end
end
