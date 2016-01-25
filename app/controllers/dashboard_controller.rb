class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index

  end

  def profile

  end

  def messages

  end

  def ads

  end

  def performances

  end

  def account

  end

  def update
    @user = current_user
    @user.update_attributes user_params
    render 'profile'
  end

  private

  def user_params
    params.require(:user).permit(:gender, :firstname, :surname, :dob, :phone_number, :language_id, :bio, :activity, addresses_attributes: [:id, :country, :state, :postcode, :city, :street])
  end

  def set_user
    @user = current_user
  end

end
