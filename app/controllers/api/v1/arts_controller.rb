class Api::V1::ArtsController < Api::BaseController
  skip_before_filter :authenticate_user!, only: :index
  def index
    @arts = Art.order('title').all
    respond_with :api, :v1, @arts
  end

end
