class Users::Balance < Struct.new(:user)
  def balance
    transactions_amount
  end

  private

  def transactions_amount
    user_transactions.sum(&:amount)
  end

  def balance_transactions
    user_transactions.balance_transactions
  end

  delegate :transactions, to: :user, prefix: true
end
