module Api
  module V1
    class ArtsController < Api::BaseController
      skip_before_action :authenticate_user!, only: :index

      resource_description do
        short 'Arts'
      end

      api! 'List of Arts'
      description <<-EOS
        ## Description
        Returns all arts.
      EOS
      example <<-EOS
        [
          {
            "created_at": "2016-04-29T05:07:20.897Z",
            "description": "",
            "id": 12,
            "title": "Gastronomie",
            "updated_at": "2016-05-10T14:45:23.815Z"
          },
          {
            "created_at": "2016-03-09T07:21:58.115Z",
            "description": "Laborum minima laboriosam. Non placeat quis. Illum omnis et.",
            "id": 8,
            "title": "Insolite",
            "updated_at": "2016-04-29T05:05:54.074Z"
          }
        ]
      EOS

      def index
        @arts = Art.order('title').all
        respond_with :api, :v1, @arts
      end
    end
  end
end
