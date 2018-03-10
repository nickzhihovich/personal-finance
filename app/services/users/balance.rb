class Users::Balance
  def initialize(user)
    @user = user
  end

  def sum
    @user.transactions.map { |transaction| transaction.amount.to_i }.sum
  end
end
