module Api
  module V1
    class ArtsController < Api::BaseController
      skip_before_action :authenticate_user!, only: :index

      def index
        @arts = Art.order('title').all
        respond_with :api, :v1, @arts
      end
    end
  end
end
