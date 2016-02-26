class Api::V1::PicturesController < Api::BaseController

  def index
    if params[:imageable_type] && params[:imageable_id]
      @pictures = current_user.shows.find(params[:imageable_id]).pictures
    end
    respond_with :api, :v1, @pictures
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.imageable.try(:user).try(:id) == current_user.id
      @picture.destroy
    else
      raise ActiveRecord::RecordNotFound
    end
    respond_with :api, :v1, @picture
  end

end
