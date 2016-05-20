module Api
  module V1
    class UsersController < Api::BaseController
      before_action :authenticate_user!, except: [:search, :show]

      resource_description do
        short 'Users'
      end

      api! 'Search by users'
      description <<-EOS
        ## Description
        Returns list of users with role `performer`.
        Ability to filter by `art_id`.
      EOS
      param :art_id, Integer, desc: 'Art ID'
      example <<-EOS
        [
          {
            "id": 29,
            "firstname": "PerfName",
            "surname": "PerfSuname",
            "full_name": "PerfName PerfSuname",
            "art_id": 14,
            "availabilities": [
              {
                "available_at": "2016-05-19"
              }
            ]
          }
        ]
      EOS

      def search
        @users = UserSearchService.new(role: :performer,
                                       art_id: params[:art_id])
                                  .results
        respond_with :api, :v1, @users
      end

      api! 'Show  user'
      description <<-EOS
        ## Description
        Returns current user's data.
      EOS
      example <<-EOS
        {
          "activity": "",
          "addresses": [
            {
              "city": "Paris",
              "country": "France",
              "created_at": "2016-04-13T07:18:42.032Z",
              "full_address": "France, Île-de-France, Rue Championnet, 131, Paris",
              "id": 37,
              "is_primary": true,
              "latitude": 48.8951238,
              "longitude": 2.3370695,
              "postcode": "75018",
              "state": "Île-de-France",
              "street": "Rue Championnet, 131",
              "updated_at": "2016-05-11T14:45:07.917Z",
              "user_id": 1
            }
          ],
          "art_id": 7,
          "available_languages": [
            {
              "id": 2,
              "title": "sed"
            },
            {
              "id": 3,
              "title": "et"
            }
          ],
          "bio": "",
          "confirmation_sent_at": null,
          "confirmation_token": null,
          "confirmed_at": "2016-05-10T14:42:38.047Z",
          "created_at": "2016-03-09T07:21:58.020Z",
          "current_sign_in_at": "2016-05-20T00:53:08.831Z",
          "current_sign_in_ip": "::1",
          "dob": "2011-01-01",
          "email": "user@example.com",
          "encrypted_password": "$2a$10$oKN3lZk0worguuHCsFxyLeVzt7lj8lKGCd4Da3J/7spExoY54.1ZS",
          "firstname": "Admin",
          "gender": "female",
          "id": 1,
          "language_ids": [
            1
          ],
          "last_sign_in_at": "2016-05-19T06:43:44.964Z",
          "last_sign_in_ip": "::1",
          "moving": false,
          "payment_methods": [],
          "phone_number": "123-456-7890",
          "picture": {
            "id": 513,
            "src": "http://s3-eu-central-1.amazonaws.com/enapparte-staging-assets/pictures/images/000/000/513/medium/image.png?1462954430"
          },
          "remember_created_at": null,
          "reset_password_sent_at": null,
          "reset_password_token": null,
          "reviews": [],
          "role": 0,
          "sent_reviews": [],
          "sign_in_count": 26,
          "surname": "Admin",
          "unconfirmed_email": null,
          "updated_at": "2016-05-20T00:53:08.867Z"
        }
      EOS

      def show
        @user = current_user
        respond_with :api, :v1, @user
      end

      api! 'Update user'
      description <<-EOS
        ## Description
        Updates user's data.
      EOS
      param :user, Hash, desc: 'User info', required: true do
        param :gender, String
        param :firstname, String, desc: ''
        param :surname, String, desc: ''
        param :dob, Date, desc: ''
        param :phone_number, String, desc: ''
        param :bio, String, desc: ''
        param :activity, String, desc: ''
        param :email, String, desc: ''
        param :password, String, desc: ''
        param :password_confirmation, String, desc: ''
        param :addresses_attributes, Hash, desc: '' do
          param :id, Integer, desc: ''
          param :country, String, desc: ''
          param :latitude, Float, desc: ''
          param :street, String, desc: ''
          param :city, String, desc: ''
          param :longitude, Float, desc: ''
          param :is_primary, Integer, desc: ''
          param :state, String, desc: ''
          param :postcode, String, desc: ''
        end
        param :picture_attributes, Hash, desc: '' do
          param :src, String, desc: ''
        end
        param :payment_methods_attributes, Hash, desc: '' do
          param :id, Integer, desc: ''
          param :user_id, Integer, desc: ''
          param :stripe_token, String, desc: ''
          param :last4, String, desc: ''
        end
        param :language_ids, Array, desc: ''
        param :showcases_attributes, Hash, desc: '' do
          param :id, Integer, desc: ''
          param :kind, String, desc: ''
          param :url, String, desc: ''
        end
      end

      def update
        @user = current_user
        @user.update_attributes user_params
        respond_with :api, :v1, @user
      end

      private

      def user_params
        params.require(:user)
              .permit(:gender, :firstname, :surname, :dob, :phone_number, :bio,
                      :activity, :email, :password, :password_confirmation,
                      addresses_attributes: [:id, :country, :latitude, :street,
                                             :city, :longitude, :is_primary,
                                             :state, :postcode],
                      picture_attributes: [:src],
                      payment_methods_attributes: [:id, :user_id, :stripe_token,
                                                   :last4],
                      language_ids: [], showcases_attributes: [:id, :kind, :url]
                     )
      end
    end
  end
end
