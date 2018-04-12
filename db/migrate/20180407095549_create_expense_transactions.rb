class CreateExpenseTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_transactions do |t|
      t.integer :category_id
      t.timestamps
    end
  end
end
