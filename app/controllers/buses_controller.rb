class BusesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bus, only: [:show, :edit, :update, :destroy]

  def index
    @buses = paginate_with_flash(Bus.all.order(created_at: :desc), per_page: 15)
    authorize @buses
  end

  def show
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(bus_params)
    authorize @bus
    if @bus.save
      redirect_to @bus, notice: "Bus created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    authorize @bus
    if @bus.update(bus_params)
      redirect_to @bus, notice: "Bus updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @bus
    @bus.destroy
    redirect_to buses_path, notice: "Bus deleted successfully."
  end

  private

  def set_bus
    if current_user.admin?
      @bus = Bus.find_by(id: params[:id])
    end
    redirect_to trips_path, alert: "Trip not found!" unless @bus
  end

  def bus_params
    params.require(:bus).permit(:bus_num, :capacity, :bus_type)
  end
end
