class PerformerMailer < ApplicationMailer

  def booking_cancelled booking
    @booking = booking
    mail to: booking.show.user.email, subject: default_i18n_subject
  end

  def booking_accepted booking
    @booking = booking
    mail to: booking.show.user.email, subject: default_i18n_subject
  end

  def booking_created booking
    @booking = booking
    if booking.show && booking.show.user
      mail to: booking.show.user.email, subject: default_i18n_subject
    end
  end

end
