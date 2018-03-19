class Users::Balance
  def initialize(user)
    @user = user
  end

  def balance
    transactions_amount
  end

  private

  attr_reader :user

  def transactions_amount
    user_transactions.sum(&:amount)
  end

  delegate :transactions, to: :user, prefix: true
end
