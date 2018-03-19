class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.date :date
      t.text :comment
      t.integer :user_id
      t.timestamps
    end
  end
end
