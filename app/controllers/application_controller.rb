class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authorize
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    not_found unless current_permission.authorized?
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user, params[:controller], params[:action])
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
