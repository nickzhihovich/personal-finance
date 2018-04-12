class Charts::Home::CategoryAmountChange
  def initialize(category:, transactions:)
    @transactions = transactions
    @category = category
  end

  def call
    amount_change
  end

  private

  def amount_change
    category_amount + category_to_amount - category_from_amount
  end

  def category_amount
    category_transacions.sum(&:amount)
  end

  def category_transacions
    @transactions.category_transactions.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_id == @category.id
    end
  end

  def category_from_amount
    category_from_transactions.sum(&:amount)
  end

  def category_from_transactions
    @transactions.between_categories.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_from_id == @category.id
    end
  end

  def category_to_amount
    category_to_transactions.sum(&:amount)
  end

  def category_to_transactions
    @transactions.between_categories.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_to_id == @category.id
    end
  end
end
