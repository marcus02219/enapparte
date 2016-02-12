class Api::V1::BookingsController < Api::BaseController

  def create
    @show = current_user.shows.create(show_params)
    respond_with :api, :v1, @show
  end

  def show
    @show = current_user.shows.find(params[:id])
    respond_with :api, :v1, @show
  end

  def update
    @show = current_user.shows.find(params[:id])
    @show.update(show_params)
    respond_with :api, :v1, @show
  end

  def toggle_active
    @show = current_user.shows.find(params[:id])
    @show.toggle_active
    respond_with :api, :v1, @show
  end

  def index
    if params[:type] == 'current'
      @shows = current_user.current_show_bookings
    elsif params[:type] == 'old'
      @shows = current_user.old_show_bookings
    elsif params[:type] == 'cancelled'
      @shows = current_user.cancelled_show_bookings
    end
    respond_with :api, :v1, @shows
  end

  def destroy
    @show = current_user.shows.find(params[:id])
    @show.destroy
    respond_with :api, :v1, @show
  end

  private

  def show_params
    params.require(:show).permit(:art_id, :max_spectators, :length, :title, :description, :language_id, :price, :cover_picture_id, :starts_at, :ends_at, pictures_attributes: [ :src, :_destroy, :id, :selected ])
  end

end
