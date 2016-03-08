# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  surface          :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  starts_at        :string
#  ends_at          :string
#  active           :boolean
#  published_at     :datetime
#  cover_picture_id :integer
#  user_id          :integer
#  art_id           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_shows_on_art_id            (art_id)
#  index_shows_on_cover_picture_id  (cover_picture_id)
#  index_shows_on_user_id           (user_id)
#

class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit]
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
