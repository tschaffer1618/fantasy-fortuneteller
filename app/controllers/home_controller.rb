class HomeController < ApplicationController
  def index
  end

  def catch_404
    raise ActionController::RoutingError.new(params[:path], failures = [params[:path]])
  end
end
