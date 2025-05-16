class PasswordsController < ApplicationController
  allow_unauthenticated_access

  layout "authentication"
  before_action :set_user_by_token, only: %i[ edit update ]

  def new; end

  def create
    respond_to do |format|
      if user = User.find_by(email_address: params[:email_address])
        PasswordsMailer.reset(user).deliver_later

        flash[:success] = "You will receive an e-mail to reset your password soon."

        format.html { redirect_to new_session_path }
      elsif user.present? && user.errors.size.positive?
        flash[:errors] = user.errors.as_json

        format.turbo_stream { render turbo_stream }
      else
        flash[:warn] = "An user with that e-mail is not registered."

        format.turbo_stream { redirect_to new_session_path }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(params.permit(:password, :password_confirmation))
        flash[:success] = "Password has been redefined."

        format.turbo_stream { render turbo_stream: turbo_stream.update("alert", partial: "errors/flash/alert", locals: { flash: flash }) }
      else
        flash[:errors] = @user.errors.as_json

        format.turbo_stream
      end
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_password_reset_token!(params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_password_path, error: "Password reset link is invalid or has expired."
  end
end
