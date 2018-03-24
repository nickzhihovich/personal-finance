require 'rails_helper'

RSpec.describe 'Users::FreeBalances', type: :feature do
  let(:user) { create(:user) }
  let(:free_balance) { Users::FreeBalance.new(user).call }
  let(:amount) { Faker::Number.between(15_000, 20_000) }
  let!(:category_transactions) { create_list(:transaction, 10, :category_trans, user: user) }
  let(:expected_balance) { amount - category_transactions.sum(&:amount) }

  before do
    create(:transaction, :balance_trans, amount: amount, user: user)
  end

  it 'calculates #free_balance' do
    expect(free_balance).to eq(expected_balance)
  end
end
