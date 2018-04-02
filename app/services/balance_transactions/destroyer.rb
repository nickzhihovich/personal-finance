class BalanceTransactions::Destroyer < Struct.new(:transaction)
  def call
    return unless valid?
    destroy_transaction
  end

  private

  def destroy_transaction
    transaction.destroy
  end

  def valid?
    user.free_balance >= amount
  end

  def user
    @_user ||= User.find(user_id)
  end

  delegate :user_id, :amount, to: :transaction
end
