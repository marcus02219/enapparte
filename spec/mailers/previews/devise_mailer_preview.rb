require 'factory_girl_rails'

class DeviseMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    user = FactoryGirl.create :user
    Devise::Mailer.confirmation_instructions(user, 'token')
  end

end

