class Users::FreeBalance < Struct.new(:user)
  def call
    free_balance
  end

  private

  def free_balance
    balance - transactions_amount
  end

  def transactions_amount
    category_transactions.sum(&:amount)
  end

  def category_transactions
    user_transactions.category_transactions
  end

  delegate :transactions, to: :user, prefix: true
  delegate :balance, to: :user
end
