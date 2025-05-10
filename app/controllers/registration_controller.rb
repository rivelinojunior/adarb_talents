class RegistrationController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  layout "authentication"

  def new; end

  def create
    respond_to do |format|
      if (user = User.create(registration_params)).persisted?
        flash[:success] = "Your account was created successfully"

        format.html { redirect_to new_session_path }
      elsif user.invalid?
        flash[:errors] = user.errors.as_json

        format.turbo_stream
      end
    end
  end


  private

  def registration_params
    params.expect(user: %i[email_address password password_confirmation])
  end
end
