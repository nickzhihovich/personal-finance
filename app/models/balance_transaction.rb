class BalanceTransaction < ApplicationRecord
  has_many :transactions, as: :transactinable, dependent: :destroy
end
