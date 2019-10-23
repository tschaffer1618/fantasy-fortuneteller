class SessionsController < ApplicationController

  def create
    # binding.pry
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    redirect_to '/'
  end

end
