class UsersController < ApplicationController
  before_action :require_user

  def show
    @user = current_user
  end

  def verify
    user = User.find(params[:user_id])
    user.update_attribute(:verified, true)
    redirect_to profile_path
    flash[:success] = "Thank you! Your account has been activated."
  end
end
