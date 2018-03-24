class BalanceTransactions::Creator
  Params = Struct.new(:date, :comment, :amount, :user_id)

  def initialize(params)
    @params = Params.new(params[:date], params[:comment], params[:amount], params[:user_id])
  end

  def create
    create_transaction
  end

  private

  def create_transaction
    transaction = BalanceTransaction.create(comment: @params[:comment])
    transaction.transactions.create(amount: @params[:amount], date: @params[:date].to_date,
                                    user_id: @params[:user_id])
  end
end
