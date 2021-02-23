class HomeController < ApplicationController
  def index
    @games = Game.all
    @groups = Group.all
  end

  def select_game
    @game = Game.find_by(name: params[:game])
    redirect_to game_groups_path(@game)
  end
end
