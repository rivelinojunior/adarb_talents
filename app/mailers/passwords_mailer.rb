class PasswordsMailer < ApplicationMailer
  default reply_to: "Ada Talents <guisousa.inacio@gmail.com>"

  def reset(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end
end
