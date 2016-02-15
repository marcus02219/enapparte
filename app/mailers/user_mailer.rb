class UserMailer < ApplicationMailer

  def booking_cancelled booking
    @booking = booking
    mail to: booking.user.email, subject: 'Votre demande de reservation a été refusée par le performeur.'
  end

end
