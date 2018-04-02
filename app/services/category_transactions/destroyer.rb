class CategoryTransactions::Destroyer < Struct.new(:transaction)
  def call
    return unless valid?
    ActiveRecord::Base.transaction do
      destroy_transaction
      update_category_balance
    end
  end

  private

  def destroy_transaction
    transaction.destroy
  end

  def update_category_balance
    category.update(amount: total_amount)
  end

  def total_amount
    category.amount - amount
  end

  def valid?
    category.amount >= amount
  end

  def category
    @_category ||= Category.find(transactinable.category_id)
  end

  delegate :amount, :transactinable, to: :transaction
end
