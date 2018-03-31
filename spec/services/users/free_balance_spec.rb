require 'rails_helper'

RSpec.describe 'Users::FreeBalances', type: :feature do
  let(:user) { create(:user) }
  let(:amount) { Faker::Number.between(15_000, 20_000) }

  let(:category) { create(:main_category, categorizable: user) }
  let(:category_transaction) { create(:category_transaction, category: category) }
  let!(:category_transactions) do
    create_list(:category_transactions, 10, user: user, transactinable: category_transaction)
  end

  let(:expected_balance) { amount - category_transactions.sum(&:amount) }
  let(:free_balance) { Users::FreeBalance.new(user).call }

  before do
    create(:balance_transactions, amount: amount, user: user)
  end

  it 'calculates #free_balance' do
    expect(free_balance).to eq(expected_balance)
  end
end
