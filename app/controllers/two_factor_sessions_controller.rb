class TwoFactorSessionsController < ApplicationController
  before_action :authenticate_user!

  def new
    # Render OTP prompt
  end

  def create
    if current_user.validate_and_consume_otp!(params[:otp_attempt]) ||
       current_user.invalidate_otp_backup_code!(params[:otp_attempt])
      remember_device if params[:remember_device] == "1"
      # redirect_to root_path_for_current_user, notice: "Signed in with two-factor authentication."
    else
      flash.now[:alert] = "Invalid code."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def remember_device
    cookies.signed[:remember_device] = {
      value: current_user.class.remember_otp_session_for_seconds.from_now.to_i,
      expires: current_user.class.remember_otp_session_for_seconds.from_now
    }
  end
end
