class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 0)
  end

  def destroy
    user =  User.find(params[:id])
    user.destroy
    flash[:success] = "User deleted!"
    redirect_to admin_users_path
  end
end
