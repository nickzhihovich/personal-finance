require 'rails_helper'

describe CategoryTransactions::Destroyer do
  subject(:destroy_transaction) { described_class.new(transaction).call }

  let(:user) { create(:user) }
  let(:category) { create(:main_category, categorizable: user) }
  let(:category_transaction) { create(:category_transaction, category: category) }
  let!(:transaction) { create(:category_transactions, transactinable: category_transaction) }

  before do
    category.update(amount: 1000)
  end

  it 'destroys the transaction' do
    expect { destroy_transaction }.to change(Transaction, :count).by(-1)
  end

  it 'destroys the category_transaction' do
    expect { destroy_transaction }.to change(CategoryTransaction, :count).by(-1)
  end
end
