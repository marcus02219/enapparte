class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :payment]
  before_action :authenticate_user!, except: [:index]

  # GET /shows
  # GET /shows.json
  def index
  end

  # GET /shows/1
  # GET /shows/1.json
  def show

  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
    render 'new'
  end

  def payment

  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      return_params = params[:show].permit(:art_id, :max_spectators, :length, :title, :description, :price, :cover_picture_id, :starts_at, :ends_at, language_ids: [])
    end
end
