class User < ApplicationRecord
  has_many :transactions

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 github]
end
