class Users::SessionsController < Devise::SessionsController
  before_action :check_otp_requirement, only: :create

  before_action :authenticate_user!, only: [ :otp_login, :verify_otp ]

  def otp_login
    # User is stored in session temporarily after password check
    @user = User.find(session[:pre_otp_user_id])
  end

  def verify_otp
    @user = User.find(session[:pre_otp_user_id])

    if @user.validate_and_consume_otp!(params[:otp_attempt])
      sign_in(@user)
      session.delete(:pre_otp_user_id)
      redirect_to authenticated_root_path, notice: "Signed in successfully with OTP."
    else
      flash.now[:alert] = "Invalid OTP. Try again."
      render :otp_login, status: :unprocessable_entity
    end
  end

  private

  def check_otp_requirement
    user = User.find_by(email: params[:user][:email])

    return unless user&.valid_password?(params[:user][:password])
    return unless user.otp_required_for_login?
    session[:pre_otp_user_id] = user.id
    redirect_to users_otp_login_path, status: :see_other
  end
end
