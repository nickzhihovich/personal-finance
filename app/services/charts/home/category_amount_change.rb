class Charts::Home::CategoryAmountChange
  def initialize(category:, transactions:)
    @transactions = transactions
    @category = category
  end

  def call
    incomes - expenses
  end

  private

  def incomes
    amount(category_transactions) + amount(category_to_transactions)
  end

  def expenses
    amount(category_from_transactions) + amount(expense_transactions)
  end

  def amount(transactions)
    transactions.sum(&:amount)
  end

  def category_transactions
    @transactions.category_transactions.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_id == @category.id
    end
  end

  def category_from_transactions
    @transactions.between_categories.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_from_id == @category.id
    end
  end

  def category_to_transactions
    @transactions.between_categories.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_to_id == @category.id
    end
  end

  def expense_transactions
    @transactions.expense_transactions.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_id == @category.id
    end
  end
end
