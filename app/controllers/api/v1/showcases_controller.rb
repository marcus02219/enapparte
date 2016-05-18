module Api
  module V1
    class ShowcasesController < Api::BaseController
      before_action :authenticate_user!

      resource_description do
        short 'Showcases'
      end

      def_param_group :showcase do
        param :showcase, Hash, desc: 'Showcase info', required: true do
          param :url, String, desc: 'URL', required: true
          param :kind, String, desc: 'Type of showcase'
        end
      end

      api! 'List of showcases'
      description <<-EOS
        ## Description
        List of showcases of current user
      EOS
      example <<-EOS
        [
          {
            "id": 2,
            "user_id": 2,
            "kind": nil,
            "url": "http://yandex.ru"
           }
        ]
      EOS
      def index
        @showcases = current_user.showcases
        respond_with :api, :v1, @showcases
      end

      api! 'Create showcases'
      description <<-EOS
        ## Description
        Creates showcases for current user
      EOS
      param_group :showcase
      example <<-EOS
        {
          "id": 2,
          "user_id": 10
          "user_id": 2,
          "kind": nil,
          "url": "http://yandex.ru",
          "created_at": "2016-05-17T16:13:11.445Z",
          "updated_at": "2016-05-17T16:13:11.445Z"
         }
      EOS
      def create
        @showcase = current_user.showcases.create(showcase_params)
        respond_with :api, :v1, @showcase
      end

      api! 'Show showcase'
      description <<-EOS
        ## Description
        Show showcase of current user
      EOS
      example <<-EOS
        {
          "id": 2,
          "user_id": 2,
          "kind": nil,
          "url": "http://yandex.ru"
         }
      EOS
      def show
        @showcase = current_user.showcases.find(params[:id])
        respond_with :api, :v1, @showcase
      end

      api! 'Update showcase'
      description <<-EOS
        ## Description
        Updates showcase of current user
      EOS
      param_group :showcase
      def update
        @showcase = current_user.showcases.find(params[:id])
        @showcase.update_attributes showcase_params
        respond_with :api, :v1, @showcase
      end

      api! 'Delete showcase'
      description <<-EOS
        ## Description
        Deletes showcase of current user
      EOS
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
