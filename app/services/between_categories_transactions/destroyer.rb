class BetweenCategoriesTransactions::Destroyer < Struct.new(:transaction)
  def call
    return unless valid?
    destroy_transaction
    update_categories_balance
  end

  private

  def destroy_transaction
    transaction.destroy
  end

  def update_categories_balance
    category_from.update(amount: category_from_total_amount)
    category_to.update(amount: category_to_total_amount)
  end

  def category_from
    Category.find(transactinable.category_from_id)
  end

  def category_to
    Category.find(transactinable.category_to_id)
  end

  def category_from_total_amount
    category_from.amount.to_i + transaction.amount
  end

  def category_to_total_amount
    category_to.amount.to_i - transaction.amount
  end

  def valid?
    category_to.amount.to_i > amount
  end

  delegate :amount, :transactinable, to: :transaction
end
