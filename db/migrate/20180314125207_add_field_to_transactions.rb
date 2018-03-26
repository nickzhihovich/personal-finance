class AddFieldToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :transactinable_type, :string
    add_column :transactions, :transactinable_id, :integer
    remove_column :transactions, :comment, :string
  end
end
