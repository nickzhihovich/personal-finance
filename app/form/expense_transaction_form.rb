class ExpenseTransactionForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  model :transaction

  property :amount
  property :date

  validates :amount, :date, presence: true
  validates :amount, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than: 0, less_than: 1_000_000_00}

  property :expense_transactions do
    property :category_id

    validates :category_id, presence: true
  end
end
