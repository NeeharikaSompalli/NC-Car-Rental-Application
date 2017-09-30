class Car < ApplicationRecord
  #before_save :price
  before_save :assign_car_id, :price
  has_many :rentals, dependent: :destroy
  validates :car_name, :presence => true, uniqueness: true, :length => { :minimum=> 2 , :message => "Must be greater than 2 letters"}
  validates :car_model, :presence => true
 # validates :car_id, :presence => true, uniqueness: true, :length => { :minimum=> 1 , :message => "Must be a valid id"}
  #validates :car_type,:presence => true, :length => { :minimum => 1 , :message => "Must select from A or B or C class"}
  validates :location,  :presence => true, :acceptance =>{accept:['FOOD LION', 'TALLEY', 'CRAB TREE', 'DOWN TOWN']}
  validates :license_plate, :presence => true, :uniqueness => true, :length => { :minimum=> 7, :maximum=> 7 , :message => "7 digit license plate"}
  validates :manufacturer, :presence => true, :acceptance =>{accept:['TESLA', 'GM', 'FORD', 'AUDI']}
  validates :style, :presence => true, :acceptance =>{accept:['SEDAN', 'SUV', 'COUPE']}
  #validates :car_price,:presence => true

  CAR_MANUFACTURERS = ['TESLA', 'GM', 'FORD', 'AUDI']
  CAR_STYLES = ['SEDAN', 'SUV', 'COUPE']
  CAR_LOCATIONS = ['FOOD LION', 'TALLEY', 'CRAB TREE', 'DOWN TOWN']
  CAR_MODELS = ['MODEL3', 'A3', 'MUSTANG', 'IMPALA']
  ALLOWED_CAR_STATUS = ['AVAILABLE', 'BOOKED', 'CHECKED-OUT']

  def available?
  rentals.empty? || rentals.map(&:start_time).min >Date.tomorrow
  end

  private
  def assign_car_id
   #self.car_id = Car.maximum(:id).to_i.next
  end

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
    rentals.each{|r| total+=self.price}
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


def isPickUpTime rental_entry

  return true if Time.now >= rental_entry.start_time && (Time.now - 30.minutes) <= rental_entry.start_time
  return false

end

def isDropOffTime rental_entry

  #return true if rental_entry.status == 'CHECKED-OUT' && Time.now >= rental_entry.from + 30.minutes && Time.now <= rental_entry.to
  return false

end
