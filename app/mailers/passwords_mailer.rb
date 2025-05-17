class PasswordsMailer < ApplicationMailer
  default reply_to: "Ada Talents #{Rails.application.credentials.dig(:smtp, :user_name)}"

  def reset(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end
end
