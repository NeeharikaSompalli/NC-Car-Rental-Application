class Rental < ApplicationRecord
  require 'date'
#attr_accessor :period
  belongs_to :car
  #belongs_to :user

  #validates :period, inclusion: { in: 30..600, :message => "cannot be less than 1 hr.Choose Between 1 to 10 hours"}
  validates :car_id, presence: true
  validates :customer_id, presence: true
  validate :period_unavailable, :date_less_than_today,:time_more_than_10_hours,:period_less_than_minimum,:period_greater_than_maximum,:date_less_than_7_days_from_now,  on: :create
  validate :period_change, on: :update

  def period_less_than_minimum
      #differnce = to - from
     #puts(to - from)
     if (end_time - start_time).to_i < 3600
       errors.add(:base, 'Booking can not be less than an hour')
     end
   end

  def period_greater_than_maximum
    #puts(to - from)
    difference = end_time-start_time
    if (end_time - start_time).to_i > 36000
    errors.add(:base, 'Booking cannot e greater than 10 hours')

    end
  end


  def time_more_than_10_hours
    if(end_time-start_time) < 0
      errors.add(:base, 'the end date should be more than start date')
    end
  end


def period_unavailable

  #errors.add(:base, 'This Car is unavailable in this period') unless Rental.where('car_id = ? AND ((from <= ? AND to >= ? ) OR (from >= ? AND to <= ?) OR (from <= ? AND to >= ?))', car_id, from, from, from, to, to, to).count == 0
    errors.add(:base, 'This Car is unavailable in this period') unless  Rental.where("(? = car_id) AND (start_time BETWEEN ? AND ? )AND (end_time BETWEEN ? AND ?)", car_id, start_time, end_time, start_time, end_time).count == 0
end

  def date_less_than_today
    if(start_time < Date.today)
      errors.add(:base, 'Date should be more than today')
    end
  end


  def date_less_than_7_days_from_now
    if( start_time > (Date.today + 7.days))
      errors.add(:base, 'Booking cannot be done more than 7 days in future')
    end
  end


  def period_change
  unless Rental.where('car_id = ? AND id <> ? AND ((start_time<= ? AND end_time >= ? ) OR (start_time >= ? AND end_time <= ?) OR (start_time <=? AND end_time >=?))',
                       car_id,id,start_time,start_time,start_time,end_time,end_time,end_time).count == 0

    errors.add(:base, 'This Car is unavailable in this period')
    end
  end

  def remove_rental_car
      where {end_time < Date.today}.destroy.all if where {end_time < Date.today}.any?
   end

  def self.get_reservations(user_id)
    reservations = where(customer_id: user_id)
    return reservations
  end
end
