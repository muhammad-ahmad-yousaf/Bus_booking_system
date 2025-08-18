class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.includes(:bus, :route).all
    authorize Trip
  end

  def show
  end


  def search
    @routes = Route.all
    if params[:start_location].present? && params[:end_location].present?
      @trips = Trip.joins(:route)
                   .where(routes: { start_location: params[:start_location], end_location: params[:end_location] })
                   .where("DATE(departure_time) = ?", params[:date])
    else
      @trips = []
    end
  end



  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to @trip, notice: 'Trip created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: 'Trip updated successfully.'
    else
      render :edit
    end
  end

  def destroy
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
