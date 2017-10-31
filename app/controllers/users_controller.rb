class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.fetch_all_customers
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if User.password_verification(params[:user][:password], params[:user][:confirm_password]) && @user.save
        if @user.user_type=='CUSTOMER'
          UserMailer.registration_confirmation(@user).deliver
          format.html { redirect_to login_session_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        elsif @user.user_type=='ADMIN'
          format.html { redirect_to show_all_admin_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to show_all_superadmin_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        end
      elsif @user.user_type=='CUSTOMER'
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif @user.user_type=='ADMIN'
        format.html { redirect_to show_all_admin_path, notice: 'Admin not created, password and confirm password does not match.' }
        format.json { render :show, status: :created, location: @user }
      elsif @user.user_type=='SUPERADMIN'
        format.html { redirect_to show_all_superadmin_path, notice: 'Superadmin not created, password and Confirm password does not match.' }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      if current_user.isAdmin?
        format.html { redirect_to home_admin_path, notice: 'Successfully destroyed.' }
      elsif current_user.isSuperadmin?
        format.html { redirect_to home_superadmin_path, notice: 'Successfully destroyed.' }
      end
    end
  end
  #Admin operations
  def new_admin
    @user = User.new
  end

  def show_all_admin
    @users = User.fetch_all_admins
  end

  def new_superadmin
    @user = User.new
  end

  def show_all_superadmin
    @users = User.fetch_all_superadmins
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :age, :user_type, :current_booking, :status)
    end
end
