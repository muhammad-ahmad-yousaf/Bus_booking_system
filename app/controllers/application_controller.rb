class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found


  def after_sign_in_path_for(resource)
    if resource.role == "admin"
      bookings_path
    else
      root_path
    end
  end

  protected

  # add name into the devise sign up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
  private

  def render_not_found
    render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
