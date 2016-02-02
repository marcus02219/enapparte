# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  active           :boolean
#  user_id          :integer
#  art_id           :integer
#  language_id      :integer
#  bookings_id      :integer
#  pictures_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cover_picture_id :integer
#  published_at     :datetime
#  starts_at        :string
#  ends_at          :string
#

class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy, :photos, :photo_upload, :pictures_count, :cover_picture, :shedules]
  before_action :authenticate_user!

  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  def photos

  end

  def cover_picture

  end

  def shedules

  end

  def pictures_count
    render json: @show.pictures.count
  end

  # GET /shows/1/edit
  def edit

  end

  # POST /shows
  # POST /shows.json
  def create
    @show = current_user.shows.build(show_params)

    respond_to do |format|
      if @show.save
        format.html { redirect_to action: :photos, id: @show.id }
        format.json { render :show, status: :created, location: @show }
      else
        format.html { render :new }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to shows_dashboard_path, notice: 'Show was successfully updated.' }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy
    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      return_params = params[:show].permit(:art_id, :max_spectators, :length, :title, :description, :language_id, :price, :cover_picture_id, :starts_at, :ends_at)
    end
end
