module Api
  class BaseController < ApplicationController
    respond_to :json
    before_action :authenticate_user!

    resource_description do
      api_version 'V1'
    end
  end
end
