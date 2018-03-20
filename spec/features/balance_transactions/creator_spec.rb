require 'rails_helper'

RSpec.describe 'BalanceTransactions::Creator', type: :feature do
  let(:user) { create(:user) }
  let(:date) { Faker::Date.between(1.year.ago, Date.current) }
  let(:comment) { Faker::Internet.slug }
  let(:amount) { Faker::Number.between(100, 1000) }
  let(:params) { {date: date, comment: comment, amount: amount, user_id: user.id} }

  it 'creates BalanceTransaction' do
    expect do
      BalanceTransactions::Creator.new(params).call
    end.to change(BalanceTransaction, :count).by(1)
  end

  it 'creates Transaction' do
    expect do
      BalanceTransactions::Creator.new(params).call
    end.to change(Transaction, :count).by(1)
  end
end
