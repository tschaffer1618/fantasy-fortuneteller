class User::TeamsController < ApplicationController
  def index
    @teams = current_user.teams
  end

  def show
  end

  def new
  end
end
