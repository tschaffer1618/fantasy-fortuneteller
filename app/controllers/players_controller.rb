class PlayersController < ApplicationController
  before_action :require_user, :require_verified_user

  def index
    @players = Player.search(params[:search])
  end

  def show
    @player = Player.find(params[:id])
  end
end
