class Charts::Home::CategoryAmountChange
  def initialize(category:, category_transactions:)
    @category_transactions = category_transactions
    @category = category
  end

  def call
    amount_change
  end

  private

  def amount_change
    all_category_transacions.sum(&:amount)
  end

  def all_category_transacions
    @category_transactions.includes(:transactinable).select do |transaction|
      transaction.transactinable.category_id == @category.id
    end
  end
end
