class Api::V1::ShowsController < Api::BaseController

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

  def index
    @shows = current_user.shows
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
