class Admin::PlayersController < Admin::BaseController
  def update_projections
    PlayerWorker.perform_async
    flash[:success] = "Player projections are being updated."
    redirect_to admin_users_path
  end
end
