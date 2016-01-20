class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def profile
    @user = current_user
  end

end
