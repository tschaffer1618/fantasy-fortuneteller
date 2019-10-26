class PlayersController < ApplicationController
  before_action :require_user, :require_verified_user
  helper_method :sort_column, :sort_direction


  # need to change attibute benched to team_players
  # team_player = player.teams_players.where(team_id: 'team_id')
  # instance method for player so when iteratiing through call it and it will just and_return
  # that players team player for the specific team show show (pass the method the @team)
  # and then you can call the .benched on that
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
  end

  private

  def sort_column
    Player.column_names.include?(params[:sort]) ? params[:sort] : "current_projection"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
