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

  private

  def set_user
    @user = current_user
  end

end
