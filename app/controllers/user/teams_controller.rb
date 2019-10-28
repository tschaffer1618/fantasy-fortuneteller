class User::TeamsController < ApplicationController
  before_action :require_user
  before_action :check_user_teams, except: [:index, :new, :create]

  def index
    @teams = current_user.teams
  end

  def show
    team = current_user.teams.find(params[:id])
    @players =  team.players
  end

  def new
    @team = Team.new
  end

  def create
    team = current_user.teams.create(team_params)
    if team.save
      flash[:success] = "New team created!"
      redirect_to user_teams_path
    else
      flash[:error] = team.errors.full_messages.to_sentence
      redirect_to new_user_team_path
    end
  end

  def edit
    @team = current_user.teams.find(params[:id])
  end

  def update
    team = current_user.teams.find(params[:id])
    team.update(team_params)
    if team.save
      flash[:success] = "Team name updated!"
      redirect_to user_teams_path
    else
      flash[:error] = team.errors.full_messages.to_sentence
      redirect_to edit_user_team_path(team)
    end
  end

  def destroy
    team = current_user.teams.find(params[:id])
    # team.team_players.destroy_all
    team.destroy
    flash[:success] = "Team deleted!"
    redirect_to user_teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def check_user_teams
    team = Team.find(params[:id])
    unless current_user.teams.include?(team)
      flash[:error] = "Forbidden"
      redirect_to user_teams_path
    end
  end
end
