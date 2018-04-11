class ExpenseTransactionForm < TransactionForm
  validate :amount_valid?

  property :date

  validates :date, presence: true

  property :expense_transactions do
    property :category_id
    property :comment

    validates :category_id, presence: true
    validates :comment, length: {maximum: 80}
  end

  private

  def amount_valid?
    errors.add(:amount, I18n.t('insufficient_funds')) if category.amount + init_amount < amount.to_f
  end

  def category
    @_category = Category.find(expense_transactions.category_id)
  end

  def init_amount
    model.amount || 0
  end
end
