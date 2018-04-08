class ExpenseTransactions::Creator
  def initialize(amount:, user_id:, category_id:, date:)
    @amount = amount
    @user_id = user_id
    @category_id = category_id
    @date = date.to_date
  end

  def create
    return unless valid?
    ActiveRecord::Base.transaction do
      create_expense_transaction
      add_transaction_to_user
      update_category_balance
    end
  end

  private

  def create_expense_transaction
    @transaction = ExpenseTransaction.create(category_id: @category_id)
  end

  def add_transaction_to_user
    @transaction.transactions.create(
      amount: @amount,
      date: @date.to_date,
      user_id: @user_id
    )
  end

  def update_category_balance
    category.update(amount: total_amount)
  end

  def valid?
    total_amount >= 0
  end

  def total_amount
    category.amount - @amount
  end

  def category
    @_category ||= Category.find(@category_id)
  end
end
