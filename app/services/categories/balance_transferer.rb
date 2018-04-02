class Categories::BalanceTransferer
  def initialize(category_from:, category_to:, amount:)
    @category_from = category_from
    @category_to = category_to
    @amount = amount
  end

  def transfer
    @category_from.update(amount: category_from_amount)
    @category_to.update(amount: category_to_amount)
  end

  private

  def category_from_amount
    @category_from.amount - @amount
  end

  def category_to_amount
    @category_to.amount + @amount
  end
end
