class ExpenseTransactionForm < TransactionForm
  property :date

  validates :date, presence: true

  property :expense_transactions do
    property :category_id
    property :comment

    validates :category_id, presence: true
    validates :comment, length: {maximum: 80}
  end
end
