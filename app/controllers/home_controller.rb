class HomeController < ApplicationController
  def index
  end

  def contact
    contact = contact_params
    UserMailer.contact_mail(contact).deliver_now
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :city, :phone, :message)
    end
end
