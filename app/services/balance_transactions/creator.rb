class BalanceTransactions::Creator
  def initialize(date:, comment:, amount:, user_id:)
    @date = date
    @comment = comment
    @amount = amount
    @user_id = user_id
  end

  def create
    ActiveRecord::Base.transaction do
      create_balance_transaction
      add_transaction_to_user
    end
  end

  private

  def create_balance_transaction
    @transaction = BalanceTransaction.create(comment: @comment)
  end

  def add_transaction_to_user
    @transaction.transactions.create(
      amount: @amount,
      date: @date.to_date,
      user_id: @user_id
    )
  end
end
