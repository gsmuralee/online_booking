require 'rails_helper'

describe Booking do

  it { should belong_to(:user) }
  it { should belong_to(:table) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:duration) }
  it { should validate_numericality_of(:duration).is_greater_than_or_equal_to(10) }
  it { should validate_numericality_of(:duration).is_less_than_or_equal_to(60) }

end
