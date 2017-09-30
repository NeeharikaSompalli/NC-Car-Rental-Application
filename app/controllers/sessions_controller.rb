class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:messages][:email], params[:messages][:password])

    if @user.nil?
      redirect_to login_session_path, notice:"Invalid email/password"
    elsif @user.user_type=='SUPERADMIN'
      session[:user_id] = @user.id
      redirect_to home_superadmin_path @user , notice:"Superadmin #{@user.name} succesfully logged-In"
    elsif @user.user_type=='ADMIN'
      session[:user_id] = @user.id
      redirect_to home_admin_path @user, notice:"Admin #{@user.name} succesfully logged-In"
    elsif @user.user_type=='CUSTOMER'
      session[:user_id] = @user.id
      redirect_to cars_path @user, notice:"Test #{@user.name} succesfully logged-In"
    end
  end

  def show
  end

  #Loads the login page when the application is started
  def login
    session[:user_id] = nil
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_session_path, notice: 'Logged out successfully'
  end

end
