class Api::BaseController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

end
