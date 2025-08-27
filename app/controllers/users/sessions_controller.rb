class Users::SessionsController < Devise::SessionsController
  def new
    if params[:return_to].present?
      session[:user_return_to] = params[:return_to]
    end
    super
  end
end
