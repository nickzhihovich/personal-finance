class ExpenseTransactions::Updater
  def initialize(date:, category_id:, amount:, transaction_id:, comment:, init_amount: 0)
    @date = date
    @category_id = category_id
    @amount = amount
    @transaction_id = transaction_id
    @init_amount = init_amount
    @comment = comment
  end

  def update
    ActiveRecord::Base.transaction do
      update_balance_transaction
      update_transaction
      update_category
    end
  end

  private

  def update_balance_transaction
    transaction.transactinable.update(category_id: @category_id, comment: @comment)
  end

  def update_transaction
    transaction.update(date: @date.to_date, amount: @amount)
  end

  def update_category
    category.update(amount: category_amount)
  end

  def category_amount
    category.amount + @init_amount - @amount
  end

  def category
    @_category = Category.find(@category_id)
  end

  def transaction
    @_transaction ||= Transaction.find(@transaction_id)
  end
end
