class PlayersController < ApplicationController
  before_action :require_user

  def index
    @players = Player.search(params[:search])
    # @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def search
  end

private

  def player_params
    params.require(:player).permit(:search)
  end
end
