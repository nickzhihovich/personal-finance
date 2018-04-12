require 'rails_helper'

describe ExpenseTransactions::Destroyer do
  subject(:destroy_transaction) { described_class.new(transaction).call }

  let(:user) { create(:user) }
  let(:category) { create(:main_category, categorizable: user, amount: 1_000) }

  let(:expense_transaction) { create(:expense_transaction, category: category) }
  let!(:transaction) { create(:expense_transactions, transactinable: expense_transaction) }

  it 'destroys the transaction' do
    expect { destroy_transaction }.to change(Transaction, :count).by(-1)
  end

  it 'destroys the expense_transaction' do
    expect { destroy_transaction }.to change(ExpenseTransaction, :count).by(-1)
  end
end
