class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @search = Car.search(params[:q])
    @cars = @search.result.where(["is_approved = :status", {status: 'TRUE'}])
    @search.build_condition
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
   # @car=Car.find(params[:id])
    @car=Car.find(params[:id])
    @rental = @car.rentals.build
  end

  # GET /cars/new
  def new
    @car = Car.new
    @rental=@car.rentals.build
  end

  # GET /cars/1/edit
  def edit
   #@car=Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html do
          redirect_to cars_path
          flash[:success] = 'Car was successfully created.'
        end
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
    #  @car=Car.find(params[:id])

      if @car.update(car_params)
      #  @rental=Rental.find(@car.rental.id)
        format.html do
          redirect_to car_path
        flash[:success] = 'Car was successfully updated.'
          end
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end
  def about
    puts"This is car Rentals Company"
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    respond_to do |format|
      format.html do
        redirect_to cars_url
        flash[:success] = 'Car was successfully destroyed.'
        end
      end
  end

  def pickup_car
      @rental = Rental.find(params[:format])
      @car = Car.find(@rental.car_id)
      @car.status = 'CHECKED-OUT'
      if @car.save
        redirect_to reservation_history_path
      end
  end

  def drop_car
    @rental = Rental.find(params[:format])
    @car = Car.find(@rental.car_id)
    @car.status = 'AVAILABLE'
    if @car.save

      @user = User.find(@rental.customer_id)
      @user.current_booking = 'FALSE'
      @user.save

      @rental.status = 'COMPLETED'
      @rental.save

      #redirect_to reservation_history_path

      redirect_to send_notification_path(@car)

    end
  end

  def suggested_cars
    @cars = Car.where(:is_approved => 'FALSE')
  end

  def approve_suggested_car
    @car = Car.find(params[:format])
    @car.is_approved = 'TRUE'
    if @car.save
      redirect_to suggested_cars_path
    end
  end

  def advanced_search
    #@cars = Car.advance_search(params[:search_field], params[:search_value])
    @search = Car.ransack(params[:q])
    @cars = @search.result.where(["is_approved = :status", {status: 'TRUE'}])

  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
      params.require(:car).permit(:car_name, :car_id, :car_model,:manufacturer, :style, :location, :car_price, :license_plate, :is_approved, :status)
    end
end
