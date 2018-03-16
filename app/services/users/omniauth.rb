class Users::Omniauth < Struct.new(:auth)
  def get
    authorization_create
  end

  private

  delegate :provider, :uid, :info, to: :auth
  delegate :email, to: :info

  def authorization_create
    authorization = user.authorizations.create_with(uid: uid).find_or_create_by(provider: provider)
    authorization.user
  end

  def generate_password
    Devise.friendly_token[0, 20]
  end

  def user
    @_user ||= User.find_or_create_by(email: email) do |user|
      user.password = generate_password
      user.confirmed_at = Date.current
    end
  end
end
