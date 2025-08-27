class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_trip, only: [:new, :create]

  def index
    authorize Booking
    @bookings = paginate_with_flash(policy_scope(Booking).order(created_at: :desc), per_page: 15)
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
      @booking.trip_id ||= @trip.id
      authorize @booking

      if @booking.save
        BookingMailer.ticket_email(@booking).deliver_later
        redirect_to bookings_path, notice: "Booking created successfully! Your ticket is sent to your email"
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
        @booking = Booking.find_by(id: params[:id])
      else
        @booking = current_user.bookings.find_by(id: params[:id])
      end
      redirect_to bookings_path, alert: "Booking not found!!" unless @booking
    end

    def set_trip
      trip_id = params[:trip_id] || booking_params[:trip_id]
      @trip = Trip.find_by(id: trip_id) if trip_id.present?

      unless @trip
        redirect_to trips_path, alert: "Trip not found!" if trip_id.present?
      end
    end

    def booking_params
      params.require(:booking).permit(:trip_id, :seat_number, :status)
    end
end
