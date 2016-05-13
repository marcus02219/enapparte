module Api
  module V1
    class UserAvailabilitiesController < Api::BaseController
      before_action :authenticate_user!

      def index
        @availabilities = current_user.availabilities
        respond_with :api, :v1, @availabilities
      end

      def show
        @availability = current_user.availabilities.find_by!(id: params[:id])
        respond_with :api, :v1, @availability
      end

      def create
        @availability = current_user.availabilities.where(availability_params)
                                    .first_or_create
        respond_with :api, :v1, @availability
      end

      def destroy
        @availability = current_user.availabilities.find_by!(id: params[:id])
        @availability.destroy
        respond_with :api, :v1, @availability
      end

      private

      def availability_params
        params.require(:availability).permit(:available_at)
      end
    end
  end
end
