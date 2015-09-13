class BookingsController < ApplicationController
  respond_to :html, :xml, :json

  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_table

  # GET /bookings
  # GET /bookings.json
  def index 
    @bookings = Booking.order_by(:start_time)
    respond_with @bookings
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # POST /bookings
  # POST /bookings.json
  def create
    params[:booking][:reference_number] = generate_uuid
    @booking =  Booking.new(params[:booking].permit(:start_time, :duration, :reference_number))
    @booking.user = current_user
    @booking.table = @table  
    if @booking.save
      flash[:notice] = 'Your booking was created succesfully'
      redirect_to "/"
    else
      render 'new'
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    if @booking.destroy
      flash[:notice] = "Booking: #{@booking.start_time.strftime('%e %b %Y %H:%M%p')} to #{@booking.end_time.strftime('%e %b %Y %H:%M%p')} deleted"
      redirect_to bookings_url
    else
      render 'index'
    end
  end

  private

    def save booking
      if @booking.save
        flash[:notice] = 'booking added'
        redirect_to resource_booking_path(@resource, @booking)
      else
        render 'new'
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:start_time, :duration)
    end

    def generate_uuid
         uuid = Time.now.strftime("%Y%m%d%H%M%S%L")
         uuid.to_i.to_s(36).upcase
    end  

    def set_table
      @table =  @table || (Table.first || Table.create_new)
    end
 
end
