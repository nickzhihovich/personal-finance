class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :email, :password, presence: true

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :confirmable, :omniauthable, omniauth_providers: %i[google github]

  scope :balance_transactions, -> { transactions.where(transactinable_type: 'BalanceTransaction') }

  def balance
    Users::Balance.new(self).balance
  end
end
