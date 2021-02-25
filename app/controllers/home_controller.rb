class HomeController < ApplicationController
  def index
    @games = Game.all
    @groups = Group.all
  end

  def select_game
    if params[:game] != ""
      @game = Game.find(params[:game])
      redirect_to game_groups_path(@game)
    else
      redirect_to root_path, notice: "Please select a game"
    end
  end
end
