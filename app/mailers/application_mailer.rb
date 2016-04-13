class ApplicationMailer < ActionMailer::Base
  default from: Setting.default_from_email
  layout 'mailer'
end
