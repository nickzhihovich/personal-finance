class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if user_from_auth.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success')
      sign_in_and_redirect user_from_auth, event: :authentication
    else
      set_devise_google_data
      redirect_to new_user_registration_url, alert: user_from_auth_error_messages
    end
  end

  def github
    @user = user_from_auth
    sign_in_and_redirect @user
  end

  private

  def set_devise_google_data
    session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
  end

  def user_from_auth_error_messages
    user_from_auth.errors.full_messages.join("\n")
  end

  def user_from_auth
    @user_from_auth ||= Users::Omniauth.new(request.env['omniauth.auth']).get
  end
end
