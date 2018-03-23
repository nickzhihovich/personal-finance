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
    ActiveRecord::Base.transaction do
      transaction = BalanceTransaction.create(comment: @params[:comment])
      transaction.transactions.create(amount: @params[:amount], user_id: @params[:user_id],
                                      date: @params[:date].to_date)
    end
  end
end
