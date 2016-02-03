class Api::V1::PicturesController < Api::BaseController

  def index
    if params[:imageable_type] && params[:imageable_id]
      @pictures = Picture.where imageable_type: params[:imageable_type], imageable_id: params[:imageable_id]
    else
      @pictures = Picture.all
    end
    respond_with :api, :v1, @pictures
  end

end
