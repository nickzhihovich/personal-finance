class BalanceTransaction < ApplicationRecord
  validates :comment, length: {maximum: 80}

  has_many :transactions, as: :transactinable, dependent: :destroy
end
