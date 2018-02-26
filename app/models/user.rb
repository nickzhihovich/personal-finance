class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    email = data['email']
    create_user_without_confirm(email)
  end

  def self.create_user_without_confirm(email)
    user = User.where(email: email).first
    user ||= User.new(email: email, password: Devise.friendly_token[0, 20])
    user.skip_confirmation!
    user.save
    user
  end
end
