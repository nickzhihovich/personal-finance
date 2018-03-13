class OauthSpecSupport
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new(user_auth_data)
  end

  def initialize(provider)
    @provider = provider
  end

  private

  attr_accessor :provider

  def user_auth_data
    {
      provider: provider,
      uid: Faker::Number.number(10),
      info: {
        email: Faker::Internet.email
      }
    }
  end
end
