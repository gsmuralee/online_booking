module Features
  module BookingHelpers

    def createBooking(day,hrs,mins,duration)
      visit root_path
      find('#booking_start_time_3i').find(:xpath, "option[@value=#{day}]").select_option
      find('#booking_start_time_4i').find(:xpath, "option[@value=#{hrs}]").select_option
      find('#booking_start_time_5i').find(:xpath, "option[@value=#{mins}]").select_option
      fill_in 'booking[duration]', with: duration
      click_button 'Submit'
    end
  end
end
