class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :verified_user?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def verified_user?
    current_user && current_user.verified
  end

  def require_user
    if current_user.nil?
      flash[:error] = "Please sign in to see this content."
      redirect_to root_path
    end
  end

  def require_verified_user
    
  end
end
