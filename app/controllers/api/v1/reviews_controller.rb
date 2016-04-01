class Api::V1::ReviewsController < Api::BaseController
  before_action :authenticate_user!, except: []

  def index
  end

end
