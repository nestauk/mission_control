class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def okta
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Okta") if is_navigational_format?
    else
      session["devise.okta_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
