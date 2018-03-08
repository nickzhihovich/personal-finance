class RenameSumToAmountInTransactions < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :sum, :amount
  end
end
