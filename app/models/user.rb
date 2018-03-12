class User < ApplicationRecord
  has_many :transactions, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :confirmable, :omniauthable, omniauth_providers: %i[google github]

  def balance
    Users::Balance.new(self).balance
  end
end
