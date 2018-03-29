class BalanceTransactions::Updater
  def initialize(date:, comment:, amount:, transaction_id:)
    @date = date
    @comment = comment
    @amount = amount
    @transaction_id = transaction_id
  end

  def update
    ActiveRecord::Base.transaction do
      update_balance_transaction
      update_transaction
    end
  end

  private

  def update_balance_transaction
    transaction.transactinable.update(comment: @comment)
  end

  def update_transaction
    transaction.update(date: @date.to_date, amount: @amount)
  end

  def transaction
    @_transaction = Transaction.find(@transaction_id)
  end
end
