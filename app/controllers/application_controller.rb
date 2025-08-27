class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found


  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.role == "admin"
      bookings_path
    else
      root_path
    end
  end

  protected

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

  def paginate_with_flash(scope, per_page: 20, page_param: params[:page])
    requested_page = (page_param || 1).to_i
    paginated = scope.page(requested_page).per(per_page)

    if requested_page > paginated.total_pages && paginated.total_pages > 0
      flash[:alert] = "Requested page does not exist. Showing the last available page."
      paginated = scope.page(paginated.total_pages).per(per_page)
    elsif paginated.empty?
      flash.now[:alert] = "No records found on this page."
    end

    paginated
  end
end
