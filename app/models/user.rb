class User < ApplicationRecord
  has_many :transactions, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :confirmable, :omniauthable, omniauth_providers: %i[google_oauth2 github]

  def balance
    transactions.map { |tr| tr.amount.to_i }.sum
  end
end
