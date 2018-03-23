class BalanceTransactionsForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(transaction_id)
    @transaction = Transaction.find(transaction_id)
    @amount = @transaction.amount
    @user_id = @transaction.user_id
    @date = @transaction.transactinable.date
    @comment = @transaction.transactinable.comment
  end

  attr_accessor :amount, :date, :user_id, :comment, :transaction_id
end
