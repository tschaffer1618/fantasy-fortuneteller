class StatsController < ApplicationController
  before_action :require_user, :require_verified_user

  def index
    @facade = LeagueStatsFacade.new
  end
end
