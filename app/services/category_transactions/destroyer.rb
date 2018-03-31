class CategoryTransactions::Destroyer < Struct.new(:transaction)
  def call
    return unless valid?
    destroy_transaction
    update_category_balance
  end

  private

  def destroy_transaction
    transaction.destroy
  end

  def update_category_balance
    category.update(amount: total_amount)
  end

  def category
    Category.find(transactinable.category_id)
  end

  def total_amount
    category.amount.to_i - amount
  end

  def valid?
    category.amount.to_i > amount
  end

  delegate :amount, :transactinable, to: :transaction
end
