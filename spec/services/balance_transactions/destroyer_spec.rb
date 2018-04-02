require 'rails_helper'

describe BalanceTransactions::Destroyer do
  subject(:destroy_transaction) { described_class.new(transaction).call }

  let!(:transaction) { create(:balance_transactions) }

  it 'destroys the transaction' do
    expect { destroy_transaction }.to change(Transaction, :count).by(-1)
  end

  it 'destroys the balance_transaction' do
    expect { destroy_transaction }.to change(BalanceTransaction, :count).by(-1)
  end
end
