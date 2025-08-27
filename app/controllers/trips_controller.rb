class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = paginate_with_flash(Trip.includes(:bus, :route).all.order(created_at: :desc), per_page: 15)
    authorize Trip
  end

  def show
  end


  def search
    redirect_to bookings_path and return if current_user&.admin?
    @routes = Route.all
    @trips = []
    if params[:date].present? || (params[:start_location].present? && params[:end_location].present?)
      @trips = Trip.search(params)
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip
    if @trip.save
      redirect_to @trip, notice: 'Trip created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    authorize @trip
    if @trip.update(trip_params)
      redirect_to @trip, notice: 'Trip updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @trip
    @trip.destroy
    redirect_to trips_path, notice: 'Trip deleted successfully.'
  end

  private
    def set_trip
      @trip = Trip.find_by(id: params[:id])
      redirect_to trips_path, alert: "Trip not found!" unless @trip
    end

    def trip_params
      params.require(:trip).permit(:bus_id, :route_id, :departure_time, :arrival_time, :avail_seats, :fare)
    end

end
