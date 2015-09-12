require 'rails_helper'

feature 'new', :booking do

  scenario 'after successful sigin should redirect to bookings page' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    page.should have_content 'Book your table'
  end
end