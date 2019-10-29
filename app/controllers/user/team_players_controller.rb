class User::TeamPlayersController < ApplicationController
  before_action :require_user
  skip_before_action :verify_authenticity_token, only: [:create]

  def destroy
    team = current_user.teams.find(team_player_params[:team_id])
    team_player = TeamPlayer.find_by(team_player_params)
    team_player.destroy
    flash[:success] = "Player deleted!"
    redirect_to user_team_path(team)
  end

  def create_from_team_show
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

  def create_from_player_search
    team = Team.find(team_player_params[:team_id])
    player = Player.find(team_player_params[:player_id])
    if TeamPlayer.does_not_exist?(team_player_params)
      TeamPlayer.create!(team_player_params)
      flash[:success] = "#{player.display_name} has been added to your team: #{team.name}"
    else
      flash[:error] = "Sorry, #{player.display_name} is already on your team: #{team.name}"
    end
    # the lines below are the only way I can figure out how to show the
    # flash message, but it does make it load more slowly
    # maybe a could place to try to implement cacheing or javascript
    redirect_to(players_path)
  end

private

  def team_player_params
    params.permit(:team_id, :player_id)
  end

end
