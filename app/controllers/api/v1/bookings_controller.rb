class Api::V1::BookingsController < Api::BaseController

  # def create
  #   @booking = current_user.bookings.create(booking_params)
  #   respond_with :api, :v1, @booking
  # end

  # def booking
  #   @booking = current_user.bookings.find(params[:id])
  #   respond_with :api, :v1, @booking
  # end

  # def update
  #   @booking = current_user.bookings.find(params[:id])
  #   @booking.update(booking_params)
  #   respond_with :api, :v1, @booking
  # end

  def change_status
    @booking = current_user.show_bookings.find(params[:id])
    @booking.change_status(params[:booking][:status])
    respond_with :api, :v1, @booking
  end

  def index
    if params[:reservation]
      @bookings = current_user.bookings
    else
      @bookings = current_user.show_bookings
    end
    respond_with :api, :v1, @bookings
  end

  # def destroy
  #   @booking = current_user.bookings.find(params[:id])
  #   @booking.destroy
  #   respond_with :api, :v1, @booking
  # end

  # private

  # def booking_params
  #   params.require(:booking).permit(:art_id, :max_spectators, :length, :title, :description, :language_id, :price, :cover_picture_id, :starts_at, :ends_at, pictures_attributes: [ :src, :_destroy, :id, :selected ])
  # end

end
