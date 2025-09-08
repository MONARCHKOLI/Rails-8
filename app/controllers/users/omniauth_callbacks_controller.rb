# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def saml
    # Here you handle the callback from SAML provider
    # For example, you can find or create the user and sign them in:
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "SAML") if is_navigational_format?
    else
      session["devise.saml_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url, alert: "Error signing in via SAML"
    end
  end
end
