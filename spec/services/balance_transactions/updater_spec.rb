require 'rails_helper'

describe BalanceTransactions::Updater do
  context 'when valid' do
    let(:amount) { Faker::Number.between(100, 1000) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Internet.slug }
    let(:transaction) { create(:balance_transactions) }

    let(:params) { {date: date, comment: comment, amount: amount, transaction_id: transaction.id} }

    before do
      described_class.new(params).update
      transaction.reload
    end

    it 'updates transaction amount' do
      expect(transaction.amount).to eq(amount)
    end

    it 'updates transaction date' do
      expect(transaction.date).to eq(date)
    end

    it 'updates transaction comment' do
      expect(transaction.transactinable.comment).to eq(comment)
    end
  end

  context 'when not valid' do
    let!(:transaction) { create(:balance_transactions) }
    let(:init_amount) { transaction.amount }
    let(:init_date) { transaction.date }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Internet.slug }

    let(:params) { {date: date, comment: comment, amount: nil, transaction_id: transaction.id} }

    before do
      described_class.new(params).update
      transaction.reload
    end

    it 'not updates transaction amount' do
      expect(transaction.amount).to eq(init_amount)
    end

    it 'not updates transaction date' do
      expect(transaction.date).to eq(init_date)
    end
  end
end
