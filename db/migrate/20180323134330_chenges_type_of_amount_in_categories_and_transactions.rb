class ChengesTypeOfAmountInCategoriesAndTransactions < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :amount, :decimal, precision: 8, scale: 2
    change_column :categories, :amount, :decimal, precision: 8, scale: 2
  end
end
