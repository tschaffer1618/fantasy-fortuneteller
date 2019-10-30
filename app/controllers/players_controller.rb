class PlayersController < ApplicationController
  before_action :require_user

  def index
    @players = Player.search(params[:search])
    # @teams = current_user.teams
    # @team_player = @teams.each...
  end

  def show
    @player = Player.find(params[:id])
  end

private

end
