class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: shared_permitted_keys.push(:remember_me))
    devise_parameter_sanitizer.permit(:account_update, keys: shared_permitted_keys)
  end
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'you_should_authorized'
    redirect_to(request.referer || root_path)
  end

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
