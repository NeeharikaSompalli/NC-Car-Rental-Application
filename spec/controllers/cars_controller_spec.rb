require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  before(:each) do
    @car = Car.create(:car_name =>'asd' , :car_model =>'',:manufacturer =>'', :style =>'', :location =>'FOOD LION', :car_price=>'', :license_plate=>'1234567', :is_approved=>'', :status=>'')
  end

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  describe 'New Car' do
    it 'renders new page' do
      get :new
      expect(response).to render_template('new')
    end
    it 'renders error on invalid car name left blank' do
      post :create, params: { car: {car_name: '', car_model: 'abc', location: 'FOOD LION', license_plate: '1234567', manufacturer: 'TESLA', style:'SEDAN' } }
      car_create = assigns(:car)
      expect(response).to render_template('new')
      expect(car_create.errors.any?).to be true
    end

    it 'renders error on invalid car model left blank' do
      post :create, params: { car: {car_name: 'car1', car_model: '', location: 'FOOD LION', license_plate: '1134567', manufacturer: 'TESLA', style:'SEDAN' } }
      car_create1 = assigns(:car)

      expect(response).to render_template('new')
      expect(car_create1.errors.any?).to be true
    end

    it 'creates car successfully' do
      post :create, params: { car: {car_name: 'car1', car_model: 'abc2', location: '', license_plate: '1134567', manufacturer: 'TESLA', style:'SEDAN' } }
      car_create1 = assigns(:car)

      expect(response).to render_template('new')
      expect(car_create1.errors.any?).to be true
    end
    it 'creates car successfully' do
      post :create, params: { car: {car_name: 'car1', car_model: 'abc2', location: 'sdfdsv', license_plate: '1134567', manufacturer: 'TESLA', style:'SEDAN' } }
      car_create1 = assigns(:car)

      expect(response).to render_template('new')
      expect(car_create1.errors.any?).to be true
    end
    it 'creates car successfully' do
      post :create, params: { car: {car_name: 'car1', car_model: 'abc2', location: 'FOOD LION', license_plate: '114567', manufacturer: 'TESLA', style:'SEDAN' } }
      car_create1 = assigns(:car)

      expect(response).to render_template('new')
      expect(car_create1.errors.any?).to be true
    end
    it 'creates car successfully' do
      post :create, params: { car: {car_name: 'car1', car_model: 'abc2', location: 'FOOD LION', license_plate: '114567', manufacturer: '', style:'SEDAN' } }
      car_create1 = assigns(:car)

      expect(response).to render_template('new')
      expect(car_create1.errors.any?).to be true
    end
    it 'creates car successfully' do
      post :create, params: { car: {car_name: 'car1', car_model: 'abc2', location: 'FOOD LION', license_plate: '114567', manufacturer: 'TESLA', style:'SEDA' } }
      car_create1 = assigns(:car)

      expect(response).to render_template('new')
      expect(car_create1.errors.any?).to be true
    end
  end

  describe 'Show' do
    it 'should render show' do
      car = create(:car)
      session[:car] = car.id
      get :show, params: { id: car.id }
      expect(response).to render_template('show')
    end
  end
  describe 'Edit profile' do
    car1 = nil
    before(:each) do
      car1 = create(:car)
      session[:car] = car1.id
    end

    it 'should render edit' do
      get :edit, params: { id: car1.id }
      expect(response).to render_template('edit')
    end
  end
end