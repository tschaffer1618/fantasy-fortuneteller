class UsersController < ApplicationController
  before_action :require_user
  before_action :require_verified_user, only: [:edit, :update]

  def show
    @user = current_user
    @teams = current_user.teams
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    flash[:success] = "Your information has been updated!" if user.save
    redirect_to profile_path
  end

  def verify
    user = User.find(params[:user_id])
    user.update_attribute(:verified, true)
    redirect_to profile_path
    flash[:success] = "Thank you! Your account has been activated."
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_name)
  end
end
