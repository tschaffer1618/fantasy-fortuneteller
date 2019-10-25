class PlayersController < ApplicationController
  before_action :require_user

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def search
  end
end
