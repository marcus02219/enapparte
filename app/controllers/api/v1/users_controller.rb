class Api::V1::UsersController < Api::BaseController

  def show
    @user = current_user
    respond_with :api, :v1, @user
  end

end
