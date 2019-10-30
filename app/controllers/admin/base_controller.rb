class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    unless current_admin?
      render file: 'public/404', status: 404
    end
  end
end
