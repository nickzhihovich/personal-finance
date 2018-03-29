class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :transactinable, dependent: :destroy, polymorphic: true

  validates :amount, :date, :user, presence: true
  validates :amount, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than_or_equal_to: 0, less_than: 1_000_000_00}

  scope :balance_transactions, -> { where(transactinable_type: 'BalanceTransaction') }
  scope :category_transactions, -> { where(transactinable_type: 'CategoryTransaction') }
end
