class BetweenCategoriesTransactionForm < TransactionForm
  validate :amount_valid?

  property :between_categories_transactions do
    property :category_from_id
    property :category_to_id

    validates :category_from_id, :category_to_id, presence: true
  end

  def amount_valid?
    errors.add(:amount, I18n.t('insufficient_funds')) if category_from.amount < amount.to_f
  end

  def category_from
    @_category_from = Category.find(between_categories_transactions.category_from_id)
  end
end
