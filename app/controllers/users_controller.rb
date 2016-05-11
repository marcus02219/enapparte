class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user
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
    params.require(:user).permit(:gender, :firstname, :surname, :dob, :phone_number, :bio, :activity, addresses_attributes: [:id, :country, :state, :postcode, :city, :street], language_ids: [])
  end

end
