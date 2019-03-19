class ApplicationController < ActionController::Base
  include Policy::Controller
  extend Policy::Controller::ClassMethods

  helper_method :signed_in?, :admin?

  def signed_in?
    current_user.present?
  end

  def admin?
    current_user&.role_admin?
  end

  rescue_from(Policy::NotAuthorizedError) do
    redirect_to root_url
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to new_session_path unless signed_in?
  end
end
