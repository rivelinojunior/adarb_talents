class ApplicationMailer < ActionMailer::Base
  default from:     "Ada Talents <#{Rails.application.credentials.mailer_email}>"
  default reply_to: "Ada Talents <#{Rails.application.credentials.mailer_email}>"

  layout "mailer"
end
