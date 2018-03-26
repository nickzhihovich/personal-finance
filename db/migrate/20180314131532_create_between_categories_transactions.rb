class CreateBetweenCategoriesTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :between_categories_transactions do |t|
      t.integer :category_from_id
      t.integer :category_to_id
      t.timestamps
    end
  end
end
