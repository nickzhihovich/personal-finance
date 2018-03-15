require 'rails_helper'

RSpec.describe 'Users::Balances', type: :feature do
  let(:user) { create(:user) }
  let(:balance) { Users::Balance.new(user).balance }
  let!(:user_transactions) { create_list(:transaction, 10, user: user) }
  let(:expected_balance) { user_transactions.map { |transaction| transaction.amount.to_i }.sum }

  it 'calculates sum of transitions' do
    expect(balance).to eq(expected_balance)
  end
end
