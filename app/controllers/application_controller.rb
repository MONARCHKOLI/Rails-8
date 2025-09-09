class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # before_action :handle_two_factor_authentication

  private

  def handle_two_factor_authentication
    return unless user_signed_in?

    if current_user.otp_required_for_login? &&
       !current_user.otp_verified?(cookies.signed[:remember_device])
      unless request.path.start_with?("/two_factor_session")
        redirect_to new_two_factor_session_path
      end
    end
  end
end
