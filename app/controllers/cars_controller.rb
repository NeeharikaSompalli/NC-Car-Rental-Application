class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
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
      #@car.status = 'CHECKED-OUT'
     # if @car.save
      #  redirect_to cars_path, notice: 'Car successfully check-out'
     # end
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
      params.require(:car).permit(:car_name, :car_id, :car_model,:manufacturer, :style, :location, :car_price, :license_plate, :is_approved, :status)
    end
end
