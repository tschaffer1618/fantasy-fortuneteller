class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    if @user.verified?
      redirect_to profile_path
    else
      UserVerificationMailer.verify(@user, server_origin).deliver_now
      redirect_to profile_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def server_origin
    request.env["HTTP_HOST"]
  end
end
