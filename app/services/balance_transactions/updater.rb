class BalanceTransactions::Updater
  Params = Struct.new(:date, :comment, :amount, :transaction_id)

  def initialize(params)
    @params = Params.new(params[:date], params[:comment], params[:amount], params[:transaction_id])
  end

  def update
    update_transaction
  end

  private

  def update_transaction
    @transaction = Transaction.find(@params[:transaction_id])
    @transaction.transactinable.update(comment: @params[:comment])
    @transaction.update(date: @params[:date].to_date, amount: @params[:amount])
  end
end
