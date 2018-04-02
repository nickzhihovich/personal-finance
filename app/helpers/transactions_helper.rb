module TransactionsHelper
  def type_block(transactinable)
    Views::TransactionTypeGenerator.new(transactinable).type_block
  end
end
