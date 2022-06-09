class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
