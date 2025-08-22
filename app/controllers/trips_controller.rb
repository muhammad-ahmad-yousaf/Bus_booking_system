class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.includes(:bus, :route).all.order(created_at: :desc).page(params[:page]).per(10)
    authorize Trip
  end

  def show
  end


  def search
    if current_user&.admin?
      redirect_to bookings_path
      return
    end

    @routes = Route.all
    @trips = []

    if params[:date].present? || (params[:start_location].present? && params[:end_location].present?)
      @trips = Trip.includes(:bus, :route)

      if params[:date].present?
        date = Date.parse(params[:date]) rescue nil
        @trips = @trips.where(departure_time: date.beginning_of_day..date.end_of_day) if date
      end

      if params[:start_location].present? && params[:end_location].present?
        @trips = @trips.joins(:route).where(routes: { start_location: params[:start_location], end_location: params[:end_location] })
      end
      @trips = @trips.where("departure_time >= ?", Time.current)
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
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:bus_id, :route_id, :departure_time, :arrival_time, :avail_seats, :fare)
    end

end
