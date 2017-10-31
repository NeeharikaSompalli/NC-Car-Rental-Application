class Car < ApplicationRecord

  before_save :price
  has_many :rentals, dependent: :destroy
  validates :car_name, :presence => true, uniqueness: true, :length => { :minimum=> 2 , :message => "Must be greater than 2 letters"}
  validates :car_model, :presence => true
  validates :location,  :presence => true, :acceptance =>{accept:['FOOD LION', 'TALLEY', 'CRAB TREE', 'DOWN TOWN']}
  validates :license_plate, :presence => true, :uniqueness => true, :length => { :minimum=> 7, :maximum=> 7 , :message => "7 digit license plate"}
  validates :manufacturer, :presence => true, :acceptance =>{accept:['TESLA', 'GM', 'FORD', 'AUDI']}
  validates :style, :presence => true, :acceptance =>{accept:['SEDAN', 'SUV', 'COUPE']}

  CAR_MANUFACTURERS = ['TESLA', 'GM', 'FORD', 'AUDI']
  CAR_STYLES = ['SEDAN', 'SUV', 'COUPE']
  CAR_LOCATIONS = ['FOOD LION', 'TALLEY', 'CRAB TREE', 'DOWN TOWN']
  CAR_MODELS = ['MODEL3', 'A3', 'MUSTANG', 'IMPALA']
  ALLOWED_CAR_STATUS = ['AVAILABLE', 'RESERVED', 'CHECKED-OUT']
  SEARCH_CATAGORIES = ['MANUFACTURER','LOCATION','MODEL','STYLE','STATUS','PRICE']

  def available?
  rentals.empty? || rentals.map(&:start_time).min >Time.now
  end

  private

  def price
    case style
      when 'SEDAN'
        self.car_price= 10
      when 'SUV'
        self.car_price=15
      when 'COUPE'
        self.car_price= 30
    end
  end


  def total_income
    total=0
    rentals.each {|r| total+=self.price}
    return total
    end
  end

  public
def getCarname car_id

  x = Car.find (car_id)

  unless x.nil?
    return Car.find(car_id).car_name
  else
    return "unknown_car"
  end
end

def calculate_total_cost(start_time, end_time, car_price)
  number_hours = end_time - start_time
  return car_price * number_hours.to_i
end

def isPickUpTime rental_entry

  return true if Time.now >= rental_entry.start_time && (Time.now - 30.minutes) <= rental_entry.start_time && rental_entry.car.status != 'CHECKED-OUT'
  return false

end

def isDropOffTime rental_entry

  #return true if rental_entry.status == 'CHECKED-OUT' && Time.now >= rental_entry.from + 30.minutes && Time.now <= rental_entry.to
  return true if rental_entry.car.status == 'CHECKED-OUT' && Time.now <= rental_entry.end_time && rental_entry.start_time <= Time.now
  return false

end