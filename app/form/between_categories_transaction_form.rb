class BetweenCategoriesTransactionForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  model :transaction

  property :amount

  validates :amount, presence: true
  validates :amount, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than: 0, less_than: 1_000_000_00}
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
