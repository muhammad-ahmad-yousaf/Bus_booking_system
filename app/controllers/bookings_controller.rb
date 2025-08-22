class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_trip, only: [:new, :create]

  def index
    @bookings = policy_scope(Booking).order(created_at: :desc).page(params[:page]).per(20)
    authorize Booking
  end

  def show
    authorize @booking
  end

  def new
    if current_user.admin?
      redirect_to bookings_path, alert: "Admins cannot create bookings."
    else
      @booking = current_user.bookings.new(trip_id: @trip.id)
      authorize @booking
    end
  end

  def create
    if current_user.admin?
      redirect_to bookings_path, alert: "Admins cannot create bookings."
    else
      @booking = current_user.bookings.new(booking_params)
      @booking.trip_id ||= @trip.id  # make sure trip_id is always set
      authorize @booking

      if @booking.save
        redirect_to bookings_path, notice: "Booking created successfully."
      else
        flash.now[:alert] = "Please select a seat before confirming."
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def update
    authorize @booking
    if @booking.update(booking_params)
      redirect_to @booking, notice: "Booking updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_path, notice: "Booking canceled successfully."
  end

  private

    def set_booking
      if current_user.admin?
        @booking = Booking.find(params[:id])
      else
        @booking = current_user.bookings.find(params[:id])
      end
    end

    def set_trip
      trip_id = params[:trip_id] || booking_params[:trip_id]
      @trip = Trip.find(trip_id)
    end

    def booking_params
      params.require(:booking).permit(:trip_id, :seat_number, :status)
    end
end
