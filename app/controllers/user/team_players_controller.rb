class User::TeamPlayersController < ApplicationController
  before_action :require_user
  skip_before_action :verify_authenticity_token


  def destroy
    team = current_user.teams.find(params[:team_id])
    team_player = TeamPlayer.find_by(player_id: params[:id], team_id: params[:team_id])
    team_player.destroy
    flash[:success] = "Player deleted!"
    redirect_to user_team_path(team)
  end

  def create
    TeamPlayer.create!(team_player_params)
  end

private

  def team_player_params
    params.permit(:team_id, :player_id)
  end
end
