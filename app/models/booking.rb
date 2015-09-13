#customized bookable
class Booking < ActiveRecord::Base
	belongs_to :user
    belongs_to :table

    validates :start_time, presence: true 
    validates :duration, presence: true, numericality: { greater_than_or_equal_to: 10, :less_than_or_equal_to => 60 }
    validate  :start_date_cannot_be_in_the_past
    validate  :overlaps
    validate :booking_cooling_period

    before_validation :calculate_end_time
  
    scope :order_by,      ->(start_time) {where("end_time >= ?", Time.now).order(start_time)}
    scope :time_constraint, ->(c1, f1, c2, f2) do
      return nil unless f1 && f2
      where "%s ? AND %s ?" % [c1, c2], f1, f2
    end

    scope :end_during,       ->(start_time, end_time) { time_constraint "end_time >",   start_time, "end_time <",   end_time }
    scope :start_during,     ->(start_time, end_time) { time_constraint "start_time >", start_time, "start_time <", end_time }
    scope :happening_during, ->(start_time, end_time) { time_constraint "start_time >", start_time, "end_time <",   end_time }
    scope :enveloping,       ->(start_time, end_time) { time_constraint "start_time <", start_time, "end_time >",   end_time }
    scope :identical,        ->(start_time, end_time) { time_constraint "start_time =", start_time, "end_time =",   end_time }
    
    scope :booking_cooling_period, ->(start_time, end_time, user_id) do 
        return nil unless start_time && end_time
        where("start_time < ? AND end_time > ? AND user_id = ?", end_time + (60.minutes),  start_time - (60.minutes), user_id)
    end

    def overlaps
	    overlapping_bookings = [ 
	      table.bookings.end_during(start_time, end_time),
	      table.bookings.start_during(start_time, end_time),
	      table.bookings.happening_during(start_time, end_time),
	      table.bookings.enveloping(start_time, end_time),
	      table.bookings.identical(start_time, end_time)
	    ].flatten
	    overlapping_bookings.delete self
	    if overlapping_bookings.any?
	      errors.add(:base, 'Slot has already been booked')
	    end
    end

    def start_date_cannot_be_in_the_past
	    if start_time && start_time < DateTime.now + (10.minutes)
	      errors.add(:start_time, 'must be at least 10 minutes from present time')
	    end
    end

    def booking_cooling_period
	    prev_bookings = user.bookings.booking_cooling_period(start_time, end_time, user.id)
	    prev_bookings.delete self
	    if prev_bookings.any?
	      errors.add(:base, 'must be a minimum cooling period of 60 minutes for each booking')
	    end
    end

    def calculate_end_time
	    start_time = validate_start_time
	    duration = validate_duration
	    if start_time && duration
	      self.end_time = start_time + (duration.minutes - 1)
	    end
    end


    def as_json(options = {})  
	   {  
	    :id => self.id,  
	    :start => self.start_time,  
	    :end => self.end_time + 1,  
	    :recurring => false, 
	    :allDay => false
	   }  
    end  

 	private

	    def validate_start_time
	      if !self.start_time.nil?
	        start_time = self.start_time
	      else
	        return nil
	      end
	    end


	    def validate_duration
	      if !self.duration.nil?
	        duration = self.duration.to_i
	      else
	        return nil
	      end
	    end  
end
