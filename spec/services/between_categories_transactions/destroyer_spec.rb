require 'rails_helper'

describe BetweenCategoriesTransactions::Destroyer do
  subject(:destroy_transaction) { described_class.new(transaction).call }

  let(:user) { create(:user) }
  let(:category_from) do
    create(:main_category, user: user, categorizable: user)
  end
  let(:category_to) { create(:main_category, user: user, categorizable: user) }
  let(:between_categories_transaction) do
    create(:between_categories_transaction, category_from: category_from, category_to: category_to)
  end

  let!(:transaction) { create(:transaction, transactinable: between_categories_transaction) }

  before do
    category_to.update(amount: 1000)
  end

  it 'destroys the transaction' do
    expect { destroy_transaction }.to change(Transaction, :count).by(-1)
  end

  it 'destroys the between_categories_transaction' do
    expect { destroy_transaction }.to change(BetweenCategoriesTransaction, :count).by(-1)
  end
end
