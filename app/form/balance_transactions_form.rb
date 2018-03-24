class BalanceTransactionsForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(transaction_id = nil)
    transaction = Transaction.find(transaction_id)
    @amount = transaction.amount
    balance_transaction = transaction.transactinable
    @date = transaction.date
    @comment = balance_transaction.comment
  end

  attr_reader :amount, :date, :comment
end
