require 'rails_helper'

RSpec.feature 'Users::Balances', type: :feature do
  let(:user) { create(:user) }
  before do
    10.times do
      create(:transaction, user: user)
    end
    @balance = Users::Balance.new(user).balance
  end

  it 'calculates sum of transitions' do
    expect(@balance).to eq(user.transactions.map { |transaction| transaction.amount.to_i }.sum)
  end
end
