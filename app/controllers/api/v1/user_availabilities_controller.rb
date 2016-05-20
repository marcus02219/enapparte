module Api
  module V1
    class UserAvailabilitiesController < Api::BaseController
      before_action :authenticate_user!

      resource_description do
        short 'User Availabilities'
      end

      api! 'List of availabilities'
      description <<-EOS
        ## Description
        Returns all availabilities of current user.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "available_at": "2016-05-13"
           }
        ]
      EOS
      def index
        @availabilities = current_user.availabilities
        respond_with :api, :v1, @availabilities
      end

      api! 'Show availability'
      description <<-EOS
        ## Description
        Returns data of certain availability.
      EOS
      example <<-EOS
        {
          "id": 1,
          "available_at": "2016-05-13"
         }
      EOS
      def show
        @availability = current_user.availabilities.find_by!(id: params[:id])
        respond_with :api, :v1, @availability
      end

      api! 'Create new availability'
      description <<-EOS
        ## Description
        Creates new availability of current user. Returns created availability
        if successful.
      EOS
      param :availability, Hash, desc: 'Availability info', required: true do
        param :available_at, Date, desc: 'Date when user is free. ' \
                                   'Format "2016-05-13"', required: true
      end
      example <<-EOS
        {
          "id": 1,
          "available_at": "2016-05-13"
         }
      EOS
      def create
        @availability = current_user.availabilities.where(availability_params)
                                    .first_or_create
        respond_with :api, :v1, @availability
      end

      api! 'Delete availability'
      description <<-EOS
        ## Description
        Deletes a certain availability.
      EOS
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
