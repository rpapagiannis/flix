class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_path, alert: "You need to sign in first!"
    end
  end

  def require_admin
    unless current_user_admin?
      redirect_to movies_path, alert: "You need to be an admin!"
    end
  end

  def current_user?(user)
    current_user == user
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user, :current_user?, :current_user_admin?
end
