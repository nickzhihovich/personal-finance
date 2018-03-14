class Users::Omniauth < Struct.new(:auth)
  def get
    authorization_user
  end

  private

  delegate :provider, :uid, :info, to: :auth
  delegate :email, to: :info

  def authorization_user
    authorization = user.authorizations.create_with(uid: uid).find_or_create_by(provider: provider)
    authorization.user
  end

  def user
    @_user ||= User.find_by(email: email) || create_user
  end

  def create_user
    Users::Creator.new(email).call
  end
end
