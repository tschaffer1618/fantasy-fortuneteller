class SessionsController < ApplicationController

  def create

    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    if @user.verified?
      redirect_to root_path
    else
      
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
