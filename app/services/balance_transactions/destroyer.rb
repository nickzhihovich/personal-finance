class BalanceTransactions::Destroyer < Struct.new(:transaction)
  def call
    return unless valid?
    destroy_transaction
  end

  private

  def destroy_transaction
    transaction.destroy
  end

  def user
    User.find(user_id)
  end

  def valid?
    user.balance - amount > user.free_balance
  end

  delegate :user_id, :amount, to: :transaction
end
