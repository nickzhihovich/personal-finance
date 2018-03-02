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

  def user
    user = User.where(provider: provider, uid: uid, email: email).first
    user ||= User.new(
      provider: provider,
      uid: uid,
      email: email,
      password: Devise.friendly_token[0, 20]
    )
    user_create(user)
  end

  def user_create(user)
    user.skip_confirmation!
    user.save
    user
  end
end
