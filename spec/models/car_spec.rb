require 'rails_helper'

RSpec.describe Car, type: :model do
  it "should check uniqueness" do
    should validate_uniqueness_of(:car_name)
  end
  it "test relation to rentals" do
    should have_many(:rentals)
  end
#    end
  it "should check length" do
    should validate_length_of(:car_name).is_at_least(2).with_message("Must be greater than 2 letters")
  end
  it "should check length" do
    should_not validate_length_of(:car_name).is_at_most(1).with_message("Must be greater than 2 letters")
  end
  it "should validate presence of car name" do
    should validate_presence_of(:car_name)
  end
  it "should validate presence of car model" do
    should validate_presence_of(:car_model)
  end
  it "should validate presence of license plate" do
    should validate_presence_of(:license_plate)
  end
  it "should validate presence of location" do
    should validate_presence_of(:location)
  end
  it "should accept only certain values for location"do
    should validate_inclusion_of(:location).
        in_array(['FOOD LION', 'TALLEY', 'CRAB TREE', 'DOWN TOWN'])
  end
  it "should check length" do
    should validate_length_of(:license_plate).is_equal_to(7).with_message("7 digit license plate")
  end
  it "should validate presence of location" do
    should validate_presence_of(:manufacturer)
    should validate_inclusion_of(:manufacturer).
        in_array(['TESLA', 'GM', 'FORD', 'AUDI'])
  end
  it "Validate presence of style" do
    should validate_presence_of(:style)
    should validate_inclusion_of(:style).
        in_array(['SEDAN', 'SUV', 'COUPE'])
  end
end
