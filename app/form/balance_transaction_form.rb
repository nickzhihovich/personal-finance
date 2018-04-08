class BalanceTransactionForm < TransactionForm
  property :date

  validates :date, presence: true

  property :balance_transactions do
    property :comment

    validates :comment, length: {maximum: 80}
  end
end
