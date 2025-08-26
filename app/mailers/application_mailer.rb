class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:email)
  layout "mailer"
end
