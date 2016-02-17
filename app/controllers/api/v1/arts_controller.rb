class Api::V1::ArtsController < Api::BaseController

  def index
    @arts = Art.order('title').all
    respond_with :api, :v1, @arts
  end

end
