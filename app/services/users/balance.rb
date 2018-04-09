class Users::Balance < Struct.new(:user)
  def balance
    transactions_amount
  end

  private

  def transactions_amount
    user_balance_transactions.sum(&:amount) - user_expense_transactions.sum(&:amount)
  end

  delegate :balance_transactions, to: :user, prefix: true
  delegate :expense_transactions, to: :user, prefix: true
end
