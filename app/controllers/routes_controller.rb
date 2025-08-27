class RoutesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  def index
    @routes = paginate_with_flash(Route.all.order(created_at: :desc), per_page: 15)
    authorize @routes
  end

  def show
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)
    authorize @route
    if @route.save
      redirect_to @route, notice: 'Route created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    authorize @route
    if @route.update(route_params)
      redirect_to @route, notice: 'Route updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @route
    @route.destroy
    redirect_to routes_path, notice: 'Route deleted successfully.'
  end

  private
    def set_route
      @route = Route.find_by(id: params[:id])
      redirect_to routes_path, alert: "Route not Found!! " unless @route
    end

    def route_params
      params.require(:route).permit(:start_location, :end_location)
    end
end
