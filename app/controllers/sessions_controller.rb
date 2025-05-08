class SessionsController < ApplicationController
  before_action :redirect_to_after_authentication_url, if: :authenticated?
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  layout "authentication"

  def new; end

  def create
    if ((user = User.find_by(params.permit(:email_address)))&.authenticate_password(params[:password])).present?
      start_new_session_for user
      flash[:success] = "Logged succesfully!"

      redirect_to root_path
    else
      flash[:warn] = "Wrong password informed."

      redirect_to new_session_path
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
