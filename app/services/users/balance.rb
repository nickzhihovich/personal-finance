class Users::Balance < Struct.new(:user)
  def balance
    transactions_amount.sum
  end

  private

  def transactions_amount
    user_transactions.map { |transaction| transaction.amount.to_i }
  end

  delegate :transactions, to: :user, prefix: true
end
