class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: shared_permitted_keys.push(:remember_me))
    devise_parameter_sanitizer.permit(:account_update, keys: shared_permitted_keys)
  end

  private

  def shared_permitted_keys
    %i[
      username
      email
      password
      password_confirmation
      remember_me
      avatar
      avatar_cache
      remove_avatar
    ]
  end
end
