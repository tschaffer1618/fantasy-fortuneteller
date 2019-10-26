class PlayersController < ApplicationController
  before_action :require_user, :require_verified_user
  helper_method :sort_column, :sort_direction


  def index
    players = Player.search(params[:search])
    @players = players.order(sort_column + " " + sort_direction)
  end

  def show
    @player = Player.find(params[:id])
  end

  def search_position
    binding.pry
  end

  private

  def sort_column
    Player.column_names.include?(params[:sort]) ? params[:sort] : "display_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
