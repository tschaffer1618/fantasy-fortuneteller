class UsersController < ApplicationController
  before_action :set_user, only: [:show, :verify, :update]

  def show
  end

  def verify
    user = User.find(params[:user_id])
    user.update_attribute(:verified, true)
    redirect_to profile_path
    # maybe add this line ?
    # flash[:success] = "Thank you! Your account has been activated."
  end

private

  def set_user
    @user = current_user
  end

  def user_params
    params.permit(:user_name)
  end
end
