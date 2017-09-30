Rails.application.routes.draw do
  get 'sessions/login'
  root 'sessions#login'

  get 'cars/pickup_car' => 'cars#pickup_car', as: :pickup
  resources :cars do
  resources :rentals
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to:'cars#index', as:"home"
  #get 'cars/:id/rentals/:id/index', to: 'rentals#index', as:"rentals_path"
  #get'/about', to: 'cars#about', as: "about"
  #get '/:id', to:'cars#show'
  #delete '/cars/:id', to: 'cars#destroy'
  #get '/show/:id', to: "cars#show" , as:"show_car"
  #get '/cars/destroy',  to:"cars#destroy"
  #Page Management
  get 'pages/customer_home' => 'pages#customer_home', as: :home_customer
  get 'pages/admin_home' => 'pages#admin_home', as: :home_admin
  get 'pages/superadmin_home' => 'pages#superadmin_home', as: :home_superadmin

  #Login Management
  get 'sessions/new' => 'sessions#new', as: :new_session
  post 'sessions' => 'sessions#create', as: :create_sessions
  get 'sessions/show'
  get 'sessions/login' => 'sessions#login', as: :login_session
  #get 'sessions/destroy', to: 'sessions#destroy', as: :logout_session
  get '/logout', to: 'sessions#destroy', as: :logout

  #Admin Management
  get 'users/new_admin' => 'users#new_admin', as: :new_admin
  get 'users/show_all_admin' => 'users#show_all_admin', as: :show_all_admin
  get 'users/delete_admin' => 'users#delete_admin', as: :delete_admin

  #superadmin Management
  get 'users/new_superadmin' => 'users#new_superadmin', as: :new_superadmin
  get 'users/show_all_superadmin' => 'users#show_all_superadmin', as: :show_all_superadmin

  #User Management
  #get 'users/new' => 'users#new', as: :new_user
  get 'users/index' => 'users#index', as: :show_all_user
  #get 'users/destroy' => 'users#destroy', as: :delete_user

  #Car Management
  #get 'cars/new' => 'cars#new', as: :new_car
  #get 'cars/index' => 'cars#index', as: :cars
  #get 'cars/destroy' => 'cars#destroy', as: :delete_car

  get 'rentals/reservation_history' => 'rentals#reservation_history', as: :reservation_history

  get 'cars/pickup_car' => 'cars#pickup_car', as: :pickup_car

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

 end

