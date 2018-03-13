class Users::Omniauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def get
    user
  end

  private

  delegate :provider, :uid, :info, to: :auth
  delegate :email, to: :info

  def authorization
    authorization = Authorization.where(provider: provider, uid: uid).first
    authorization ||= Authorization.new(provider: provider, uid: uid)
    authorization.user
  end

  def user
    user = User.where(email: email).first
    user_create(user)
  end

  def create_user_for_authorization
    if authorization.blank?
      authoriz = authorization
      authoriz.user = user
      authoriz.save
    end
    authorization
  end

  def user_create(user)
    user ||= User.new(
      email: email,
      password: Devise.friendly_token[0, 20]
    )
    user.skip_confirmation!
    user.save
    user
  end
end
