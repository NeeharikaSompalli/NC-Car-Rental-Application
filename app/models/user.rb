class User < ApplicationRecord
  has_many :rentals
  validates :name, :presence => true, :length => { :minimum=> 3 , :message => "Name must be longer than 3 letters"}
  validates :email, :presence => true, :uniqueness => true, format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/}
  validates :password, :presence => true, :length => {:minimum=> 6, :maximum => 10, :message => "Password must be between 6 to 10 characters"}
  validates :user_type, :presence => true, :acceptance =>{accept:['CUSTOMER', 'ADMIN', 'SUPERADMIN']}
  validates :status, :presence => true
  validates :current_booking, :presence => true

  def authenticate_Password?(entered_password)
    password == entered_password
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?
    return user if user.authenticate_Password?(submitted_password)
  end

  def self.fetch_all_superadmins
    admins = where(user_type: 'SUPERADMIN')
    return admins
  end

  def self.fetch_all_admins
    admins = where(user_type: 'ADMIN')
    return admins
  end

  def self.fetch_all_customers
    users = where(user_type: 'CUSTOMER')
    return users
  end

  def isCustomer?
    return false unless user_type == 'CUSTOMER'
    return true
  end

  def isAdmin?
    return false unless user_type == 'ADMIN'
    return true
  end

  def isSuperadmin?
    return false unless user_type == 'SUPERADMIN'
    return true
  end

  #soft delete
  def deleteUser
    status = 'N'
  end

  def change_current_booking_status
    current_booking = 'TRUE'
  end

  def self.fetch_current_customer(current_user_id)
    return User.where(id: current_user_id)
  end

end
