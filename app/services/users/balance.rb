class Users::Balance < Struct.new(:user)
  def balance
    transactions_amount
  end

  private

  def transactions_amount
    balance_transactions.sum(&:amount)
  end

  delegate :transactions, to: :user, prefix: true
end
