class UserMailer < ApplicationMailer

  default :from => "admin@ncsucarrental.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered"  )
  end

  def inform_user_about_car(user, car)
    @user = user
    @car = car
    mail(:to => user.email, :subject => "Car is available"  )
  end

end
