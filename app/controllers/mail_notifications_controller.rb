class MailNotificationsController < ApplicationController
  before_action :set_mail_notification, only: [:show, :edit, :update, :destroy]

  # GET /mail_notifications
  # GET /mail_notifications.json
  def index
    @mail_notifications = MailNotification.all
  end

  # GET /mail_notifications/1
  # GET /mail_notifications/1.json
  def show
  end

  # GET /mail_notifications/new
  def new
    @mail_notification = MailNotification.new
  end

  # GET /mail_notifications/1/edit
  def edit
  end

  # POST /mail_notifications
  # POST /mail_notifications.json
  def create
    @mail_notification = MailNotification.new(mail_notification_params)

    respond_to do |format|
      if @mail_notification.save
        format.html { redirect_to @mail_notification, notice: 'Mail notification was successfully created.' }
        format.json { render :show, status: :created, location: @mail_notification }
      else
        format.html { render :new }
        format.json { render json: @mail_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_notifications/1
  # PATCH/PUT /mail_notifications/1.json
  def update
    respond_to do |format|
      if @mail_notification.update(mail_notification_params)
        format.html { redirect_to @mail_notification, notice: 'Mail notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_notification }
      else
        format.html { render :edit }
        format.json { render json: @mail_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_notifications/1
  # DELETE /mail_notifications/1.json
  def destroy
    @mail_notification.destroy
    respond_to do |format|
      format.html { redirect_to mail_notifications_url, notice: 'Mail notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_notification
    @car = Car.find(params[:format])
    #@mailers = MailNotification.where(car_id: params[:format] )

    @mailers = MailNotification.where(['car_id == ? AND status == ?',params[:format], 'NOTIFY'])

    @mailers.each do |individual_mail|
      @user = User.find(individual_mail.customer_id)
      UserMailer.inform_user_about_car(@user, @car).deliver
      individual_mail.status='NOTIFIED'
      individual_mail.save
    end

    redirect_to reservation_history_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_notification
      @mail_notification = MailNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_notification_params
      params.require(:mail_notification).permit(:car_id, :customer_id, :status)
    end
end
