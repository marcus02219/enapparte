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

  def toggle_active
    @show = current_user.shows.find(params[:id])
    @show.toggle_active
    respond_with :api, :v1, @show
  end

  def index
    @shows = current_user.shows
    respond_with :api, :v1, @shows
  end

  def search
    if params[:q]
      response = Show.search(params[:q])
      ap response.records
      @shows = response.records.where(active: true).order('rating desc').all
    else
      @shows = Show.where(active: true).order('rating desc').all
    end
    respond_with :api, :v1, @shows
  end

  def destroy
    @show = current_user.shows.find(params[:id])
    @show.destroy
    respond_with :api, :v1, @show
  end

  def arts
    art_ids = Show.where(active: true).group('art_id').select('art_id').map(&:art_id)
    @arts = art_ids.map {|id| Art.find_by_id(id) }.select {|art| art.present? }
    respond_with :api, :v1, @arts
  end

  private

  def show_params
    params.require(:show).permit(:art_id, :max_spectators, :length, :title, :description, :language_id, :price, :cover_picture_id, :starts_at, :ends_at, pictures_attributes: [ :src, :_destroy, :id, :selected ])
  end

end
