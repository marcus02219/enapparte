# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  firstname              :string
#  surname                :string
#  gender                 :integer
#  sex                    :integer
#  bio                    :text
#  phone_number           :string
#  provider               :string
#  uid                    :integer
#  dob                    :date
#  activity               :string
#  language_id            :integer
#  addresses_id           :integer
#  bookings_id            :integer
#  payment_methods_id     :integer
#  shows_id               :integer
#  picture_id             :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def upload_photo
    @user = current_user
    if params[:image]
      @user.picture.image = params[:image]
      @user.picture.save
    end
    render json: { image: @user.picture.image.url(:medium) }
  end

  def update
    @user = current_user
    @user.update_attributes user_params
    redirect_to profile_dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:gender, :firstname, :surname, :dob, :phone_number, :language_id, :bio, :activity, addresses_attributes: [:country, :state, :postcode, :city, :street])
  end

end
