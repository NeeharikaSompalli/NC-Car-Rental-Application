# spec/support/factory_girl.rb
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :car do |car|
    car.car_name "car1"
    car.car_model "MUSTANG"
    car.manufacturer "TESLA"
    car.style "SEDAN"
    car.location "FOOD LION"
    car.car_price "10"
    car.license_plate "1147567"
    car.is_approved "YES"
    car.status "AVAILABLE"
    car.id "123"
  end
end