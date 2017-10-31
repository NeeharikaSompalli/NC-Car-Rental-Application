class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :set_car, only: [:index, :new, :create, :edit, :update, :destroy]

  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = @car.rentals.all
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
    #@rental = @car.rentals.build[:id]
    #@car=Car.find(params[:id])

  end

  # GET /rentals/new
  def new
    @rental = Rental.new
    @rental = @car.rentals.new
  end

  # GET /rentals/1/edit
  def edit
    @rental=Rental.find(params[:id])

  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = @car.rentals.build(rental_params)

    #current_user.change_current_booking_status
    respond_to do |format|
      if @rental.save

        @car.status = 'RESERVED'
        @car.save

        @user = User.find(@rental.customer_id)
        @user.current_booking = 'TRUE'
        @user.save

        CarPickupFailedJob.set(wait_until: (@rental.start_time + 30.minutes)).perform_later(@rental, @user, @car)
        CarDropoffFailJob.set(wait_until: @rental.end_time).perform_later(@rental, @user, @car)

        format.html { redirect_to cars_path, notice: 'car was successfully booked.' }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html do
          redirect_to car_rentals_path(@car)
          flash[:success] = 'Booking was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html do
        redirect_to car_rentals_path(@car)
        flash[:success] = 'Booking was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def reservation_history
    @rentals = Rental.get_reservations(current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

  def set_car
    @car = Car.find(params[:car_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:car_id,:customer_id, :start_time, :end_time)
    end
end
