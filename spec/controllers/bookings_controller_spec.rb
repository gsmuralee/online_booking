require 'rails_helper'

RSpec.describe BookingsController, type: :controller do

    describe "GET #index" do
        
    	before(:each){ 
           @user = FactoryGirl.create(:user)
           sign_in @user  
    	}

		it "populates an array of contacts" do
		    booking = FactoryGirl.create(:booking, user: @user)
		    get :index
		    assigns(:bookings).should eq([booking])
		end
	  
		it "renders the :index view" do
		    get :index
		    response.should render_template :index
		end
    end

    describe "GET #show" do

    	before(:each){ 
           @user = FactoryGirl.create(:user)
           sign_in @user  
    	}

	    it "assigns the requested booking to @booking" do
		    booking = FactoryGirl.create(:booking, user: @user)
		    get :show, id: booking
		    assigns(:booking).should eql booking
        end
  
	    it "renders the #show view" do
		    get :show, id: FactoryGirl.create(:booking, user: @user)
		    response.should render_template :show
	    end
	end

	describe "GET #new" do

		before(:each){ 
           @user = FactoryGirl.create(:user)
           sign_in @user  
    	}

		it "takes two parameters and returns a Booking object" do
			booking = Booking.new(start_time: DateTime.now, duration: 10)
		    get :new
		    booking.should be_an_instance_of Booking
		end
    end

    describe "POST create" do
    	before(:each){ 
           @user = FactoryGirl.create(:user)
           sign_in @user  
    	}
		context "with valid attributes" do
		    it "creates a new booking" do
		      post :create, booking: FactoryGirl.attributes_for(:booking)
		      response.should redirect_to root_path
		    end
        end
  
    end

    describe "POST create" do
    	before(:each){ 
           @user = FactoryGirl.create(:user)
           sign_in @user  
    	}
		context "with valid attributes" do
		    it "creates a new booking" do
		      post :create, booking: FactoryGirl.attributes_for(:booking)
		      response.should redirect_to root_path
		    end
        end
  
    end

    describe 'DELETE destroy' do
		before :each do
		    @user = FactoryGirl.create(:user)
            sign_in @user  
        end
		    
		it "redirects to contacts#index" do
			booking = FactoryGirl.create(:booking, user: @user)
		    delete :destroy, id: booking
		    response.should redirect_to bookings_path
		end
    end

end
