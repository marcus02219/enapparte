# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def booking_cancelled
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show = FactoryGirl.create :show, user: user2
    booking = FactoryGirl.create :booking, show: show, user: user

    UserMailer.booking_cancelled(booking)
  end

  def booking_accepted
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show = FactoryGirl.create :show, user: user2
    booking = FactoryGirl.create :booking, show: show, user: user

    UserMailer.booking_accepted(booking)
  end

  def booking_created
    user = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show = FactoryGirl.create :show, user: user2
    booking = FactoryGirl.create :booking, show: show, user: user

    UserMailer.booking_created(booking)
  end
end
