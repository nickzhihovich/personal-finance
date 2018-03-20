require 'rails_helper'

RSpec.describe 'BalanceTransactions::Updater', type: :feature do
  let(:amount) { Faker::Number.between(100, 1000) }
  let(:date) { Faker::Date.between(1.year.ago, Date.current) }
  let(:comment) { Faker::Internet.slug }
  let(:transaction) { create(:transaction) }

  let(:params) { {date: date, comment: comment, amount: amount, transaction_id: transaction.id} }

  before do
    BalanceTransactions::Updater.new(params).call
    transaction.reload
  end

  it 'updates transaction amount' do
    expect(transaction.amount).to eq(amount)
  end

  it 'updates transaction date' do
    expect(transaction.transactinable.date).to eq(date)
  end

  it 'updates transaction comment' do
    expect(transaction.transactinable.comment).to eq(comment)
  end
end
