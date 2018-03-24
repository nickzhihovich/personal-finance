class BalanceTransactions::Form < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  property :date
  property :comment

  validation do
    required(:date).filled
  end

  property :amount

  validation do
    required(:amount).filled
  end
end
