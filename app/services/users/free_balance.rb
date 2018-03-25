class Users::FreeBalance < Struct.new(:user)
  def call
    free_balance
  end

  private

  def free_balance
    balance - transactions_amount
  end

  def transactions_amount
    user_category_transactions.sum(&:amount)
  end

  delegate :category_transactions, to: :user, prefix: true
  delegate :balance, to: :user
end
