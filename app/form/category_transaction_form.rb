class CategoryTransactionForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  model :transaction

  property :amount
  property :user_id

  validates :amount, presence: true
  validates :amount, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than: 0, less_than: 1_000_000_00}

  validate :amount_valid?

  def amount_valid?
    errors.add(:amount, I18n.t('insufficient_funds')) if free_balance < amount.to_f
  end

  def free_balance
    user = User.find(user_id)
    user.free_balance
  end
end
