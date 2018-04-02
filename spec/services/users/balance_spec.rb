require 'rails_helper'

RSpec.describe 'Users::Balances', type: :feature do
  let(:user) { create(:user) }
  let(:balance) { Users::Balance.new(user).balance }
  let!(:user_transactions) { create_list(:balance_transactions, 10, user: user) }
  let(:expected_balance) { user_transactions.sum(&:amount) }

  it 'calculates sum of transitions' do
    expect(balance).to eq(expected_balance)
  end
end
