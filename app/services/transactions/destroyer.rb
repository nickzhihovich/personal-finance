class Transactions::Destroyer < Struct.new(:transaction)
  def call
    transaction_destroy
  end

  private

  def transaction_destroy
    case transactinable
    when BalanceTransaction
      BalanceTransactions::Destroyer.new(transaction).call
    when CategoryTransaction
      CategoryTransactions::Destroyer.new(transaction).call
    when BetweenCategoriesTransaction
      BetweenCategoriesTransactions::Destroyer.new(transaction).call
    when ExpenseTransaction
      ExpenseTransactions::Destroyer.new(transaction).call
    end
  end

  delegate :transactinable, to: :transaction
end
