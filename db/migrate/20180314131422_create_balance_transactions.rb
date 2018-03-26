class CreateBalanceTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :balance_transactions do |t|
      t.string :comment
      t.timestamps
    end
  end
end
