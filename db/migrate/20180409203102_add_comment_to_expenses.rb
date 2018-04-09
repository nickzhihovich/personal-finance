class AddCommentToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expense_transactions, :comment, :string
  end
end
