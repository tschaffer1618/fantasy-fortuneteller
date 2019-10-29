class User::TeamPlayersController < ApplicationController
  before_action :require_user
  skip_before_action :verify_authenticity_token, only: [:create]

  def destroy
    team = current_user.teams.find(params[:team_id])
    team_player = TeamPlayer.find_by(player_id: params[:id], team_id: params[:team_id])
    team_player.destroy
    flash[:success] = "Player deleted!"
    redirect_to user_team_path(team)
  end

  def create
    player = Player.find_by(display_name: params[:myPlayer])
    team = current_user.teams.find(params[:team_id])
    if player
      team_player = TeamPlayer.find_or_initialize_by(player: player, team: team)
      if team_player.new_record?
        team_player.save
        flash[:success] = "Player added!"
      else
        flash[:error] = "Player already on team."
      end
    else
      flash[:error] = "No player found matching that name."
    end
    redirect_to user_team_path(team)
  end

end
