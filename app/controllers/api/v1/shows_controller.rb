class Api::V1::ShowsController < Api::BaseController
  respond_to :json

  def create
    @show = Show.create(show_params.merge({ user: current_user }))
    respond_with :api, :v1, @show
  end

  def show
    @show = Show.include(:pictures).find(params[:id])
    respond_with :api, :v1, @show
  end

  private

  def show_params
    params[:show].permit(:art_id, :max_spectators, :length, :title, :description, :language_id, :price, :cover_picture_id, :starts_at, :ends_at)
  end

end
