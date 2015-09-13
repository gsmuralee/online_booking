require 'rails_helper'

feature 'new', :booking do

  scenario 'after successful sigin should redirect to bookings page' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    page.should have_content 'Book your table'
  end

  scenario 'create booking in past should throw error' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    page.should have_content 'Book your table'
    createBooking(DateTime.now.day - 1, DateTime.now.hour, "%.2d" % ((DateTime.now.minute/5)*5), 10)
    page.should have_content 'Start time must be at least 10 minutes from present time'
  end

   scenario 'bookings should create new record' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    page.should have_content 'Book your table'
    time = DateTime.now.utc + 1.hour
    createBooking("%.2d" % time.day, "%.2d" % time.hour, "%.2d" % ((time.minute/5)*5), 20)
    page.should have_content 'Your booking was created succesfully'
  end
  
  scenario 'clicking home icon should get to home' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    page.should have_content 'Book your table'
    find('.glyphicon-home').click
    page.should have_content 'Book your table'
  end

  scenario 'clicking list icon should get to bookings index page' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    page.should have_content 'Book your table'
    visit bookings_path
    page.should have_content 'Your Bookings List'
  end

end