class User::TeamsController < ApplicationController
  def index
    @teams = current_user.teams
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    team = current_user.teams.create(team_params)
    flash[:success] = "New team created!" if team.save
    redirect_to user_teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
