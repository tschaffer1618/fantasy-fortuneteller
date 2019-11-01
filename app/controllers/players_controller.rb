class PlayersController < ApplicationController
  before_action :require_user, :require_verified_user
  helper_method :sort_column, :sort_direction

  def index
    if params[:position]
      @players = Player.search_position(params[:position]).order(current_projection: :desc)
    else
      players = Player.search(params[:search])
      if params[:sort] != "current_projection"
        @players = players.order(sort_column + " " + sort_direction).order(current_projection: :desc)
      else
        @players = players.order(sort_column + " " + sort_direction)
      end
    end
  end

  def show
    @player = Player.find(params[:id])
    @projections = UpdateService.new.get_all_projections(@player)
  end
end
