class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :verified_user?, :current_user, :current_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def verified_user?
    current_user && current_user.verified
  end

  def require_user
    if current_user.nil?
      flash[:error] = 'Please sign in to see this content.'
      redirect_to root_path
    end
  end

  def require_verified_user
    unless verified_user?
      flash[:error] = 'Please verify your account to see this content.'
      redirect_to profile_path
    end
  end

  def current_admin?
    current_user && current_user.admin?
  end

  rescue_from ActionController::RoutingError do |exception|
    logger.error "Routing error: #{exception.failures.first}"
    render file: 'public/404', status: 404
  end
end
