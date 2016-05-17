module Api
  module V1
    class ShowcasesController < Api::BaseController
      before_action :authenticate_user!

      def index
        @showcases = current_user.showcases
        respond_with :api, :v1, @showcases
      end

      def create
        @showcase = current_user.showcases.create(showcase_params)
        respond_with :api, :v1, @showcase
      end

      def show
        @showcase = current_user.showcases.find(params[:id])
        respond_with :api, :v1, @showcase
      end

      def update
        @showcase = current_user.showcases.find(params[:id])
        @showcase.update_attributes showcase_params
        respond_with :api, :v1, @showcase
      end

      def destroy
        @showcase = current_user.showcases.find(params[:id])
        @showcase.destroy
        respond_with :api, :v1, @showcase
      end

      private

      def showcase_params
        params.require(:showcase).permit(:kind, :url)
      end
    end
  end
end
