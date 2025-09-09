class TwoFactorSettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    # Just shows whether 2FA is enabled or not
  end

  def setup
    @user = current_user
    # Assign a new secret if not already set
    unless @user.otp_secret.present?
      @user.otp_secret = User.generate_otp_secret
      @user.save!
    end

    @provisioning_uri = @user.otp_provisioning_uri(
      @user.email,
      issuer: Rails.application.class.module_parent_name
    )
  end

  def confirm
    @user = current_user
    if @user.validate_and_consume_otp!(params[:otp_attempt])
      @user.update!(otp_required_for_login: true)
      @backup_codes = @user.generate_otp_backup_codes!
      @user.save!
      render :backup_codes
    else
      flash[:alert] = "Invalid code. Please try again."
      redirect_to setup_two_factor_settings_path
    end
  end

  def disable
    current_user.update!(
      otp_required_for_login: false,
      otp_secret: nil,
      otp_backup_codes: nil
    )
    redirect_to two_factor_settings_path, notice: "Two-factor authentication disabled."
  end

  def regenerate_backup_codes
    @user = current_user
    @backup_codes = @user.generate_otp_backup_codes!
    @user.save!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "backup_codes_frame",
          partial: "two_factor_settings/backup_codes",
          locals: { backup_codes: @backup_codes }
        )
      end
      format.html { redirect_to edit_user_registration_path, notice: "Backup codes regenerated" }
    end
  end
end
