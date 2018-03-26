class CreateCategoryTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :category_transactions do |t|
      t.integer :category_id
      t.timestamps
    end
  end
end
