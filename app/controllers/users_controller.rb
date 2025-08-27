class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = paginate_with_flash(User.all.order(created_at: :desc), per_page: 15)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def authorize_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
