class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    unless current_admin?
      flash[:error] = "You are not authorized to see this content."
      redirect_to root_path
    end
  end
end
