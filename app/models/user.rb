class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
end
