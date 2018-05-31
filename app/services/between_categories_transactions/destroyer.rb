class BetweenCategoriesTransactions::Destroyer < Struct.new(:transaction)
  def call
    return unless valid?
    ActiveRecord::Base.transaction do
      destroy_transaction
      transfer_money_between_categories
    end
  end

  private

  def destroy_transaction
    transaction.destroy
  end

  def transfer_money_between_categories
    Categories::BalanceTransferer.new(
      category_from: category_to,
      category_to: category_from,
      amount: amount
    ).transfer
  end

  def valid?
    category_to.amount >= amount
  end

  def category_from
    @category_from ||= Category.find(transactinable.category_from_id)
  end

  def category_to
    @category_to ||= Category.find(transactinable.category_to_id)
  end

  delegate :amount, :transactinable, to: :transaction
end
