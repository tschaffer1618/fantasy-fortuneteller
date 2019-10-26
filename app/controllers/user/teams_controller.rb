class User::TeamsController < ApplicationController
  before_action :require_verified_user
  before_action :check_user_teams, except: [:index, :new, :create]

  def index
    @teams = current_user.teams
  end

  # need to change attibute benched to team_players
  # team_player = player.teams_players.where(team_id: 'team_id')
  # instance method for player so when iteratiing through call it and it will just and_return
  # that players team player for the specific team show show (pass the method the @team)
  # and then you can call the .benched on that
  def show
    @team = current_user.teams.find_by_id(params[:id].to_i)
    if params[:benched]
      binding.pry
      @players =  @team.players.update_attribute(:benched, params[:benched])
    else
      @players =  @team.players
    end
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
    if team.update(team_params)
      flash[:success] = "Team name updated!"
      redirect_to user_teams_path
    else
      flash[:error] = team.errors.full_messages.to_sentence
      redirect_to edit_user_team_path(team)
    end
  end

  def destroy
    team = current_user.teams.find(params[:id])
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
