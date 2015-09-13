require 'rails_helper'

describe Booking do
   before(:each) { 
    @booking = FactoryGirl.create :booking
   	@user, @table = @booking.user,  @booking.table
    @user1 = FactoryGirl.create(:user, email:"test@factory.com", password: "newpassword-1")
   }

  it { should belong_to(:user) }
  it { should belong_to(:table) }
  it { @booking.should validate_presence_of(:start_time) }
  it { @booking.should validate_presence_of(:duration) }
  it { @booking.should validate_numericality_of(:duration).is_greater_than_or_equal_to(10) }
  it { @booking.should validate_numericality_of(:duration).is_less_than_or_equal_to(60) }

  it "#start date cannot be in the past" do
    build(:booking, start_time: DateTime.now - (10.minutes), duration: 10, user_id: @user.id).should_not be_valid
  end

  it "#start date should be in the future" do
    @booking.should be_valid
  end
  
  it "#prev booking should not end during current booking" do
    build(:booking, start_time: DateTime.now + (15.minutes), duration: 15, user_id: @user1.id, table_id: @table.id).should_not be_valid
  end

  it "#prev booking should not start during current booking" do
    build(:booking, start_time: DateTime.now + (25.minutes), duration: 40, user_id: @user1.id, table_id: @table.id).should_not be_valid
  end
  
  it "#prev booking should not happen during current booking" do
    build(:booking, start_time: DateTime.now + (25.minutes), duration: 10, user_id: @user1.id, table_id: @table.id).should_not be_valid
  end

  it "#prev booking should not envelop current booking" do
    build(:booking, start_time: DateTime.now + (10.minutes), duration: 50, user_id: @user1.id, table_id: @table.id).should_not be_valid
  end

  it "#prev booking should not be identical to current booking" do
    build(:booking, start_time: DateTime.now + (15.minutes), duration: 30, user_id: @user1.id, table_id: @table.id).should_not be_valid
  end

  it "#each booking should have 60 mins cooling period" do
    build(:booking, start_time: DateTime.now + (15.minutes), duration: 10, user_id: @user.id, table_id: @table.id).should_not be_valid
  end  

end
