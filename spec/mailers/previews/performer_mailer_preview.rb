# Preview all emails at http://localhost:3000/rails/mailers/performer_mailer

require 'factory_girl_rails'

class PerformerMailerPreview < ActionMailer::Preview

  def booking_cancelled
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show = FactoryGirl.create :show, user: user2
    booking = FactoryGirl.create :booking, show: show, user: user

    PerformerMailer.booking_cancelled(booking)
  end

  def booking_accepted
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show = FactoryGirl.create :show, user: user2
    booking = FactoryGirl.create :booking, show: show, user: user

    PerformerMailer.booking_accepted(booking)
  end

  def booking_created
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show = FactoryGirl.create :show, user: user2
    # address = FactoryGirl.create :address
    booking = FactoryGirl.create :booking, show: show, user: user#, address: address

    PerformerMailer.booking_created(booking)
  end

end
