class Users::Balance
  def initialize(user)
    @user = user
  end

  def balance
    transactions_amount.sum
  end

  private

  attr_reader :user

  def transactions_amount
    user_transactions.map { |transaction| transaction.amount.to_i }
  end

  delegate :transactions, to: :user, prefix: true
end
