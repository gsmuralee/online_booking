class Booking < ActiveRecord::Base
	belongs_to :user
	belongs_to :table

	validates :start_time, presence: true 
    validates :duration, presence: true, numericality: { greater_than_or_equal_to: 10, :less_than_or_equal_to => 60 }
end
