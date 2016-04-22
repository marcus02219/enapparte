class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.default_from_email
  layout 'mailer'
end
