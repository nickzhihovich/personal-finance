require 'rails_helper'

describe ExpenseTransactions::Updater do
  let(:user) { create(:user) }
  let(:category) { create(:main_category, categorizable: user, amount: 1_000) }

  let(:expense_transaction) { create(:expense_transaction, category: category) }
  let!(:transaction) { create(:expense_transactions, transactinable: expense_transaction) }

  context 'when valid' do
    let(:amount) { Faker::Number.between(100, 1000) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Internet.slug }

    let(:params) do
      {
        date: date,
        category_id: category.id,
        amount: amount,
        transaction_id: transaction.id,
        comment: comment
      }
    end

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
  end

  context 'when not valid' do
    let(:init_amount) { transaction.amount }
    let(:init_date) { transaction.date }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Internet.slug }

    let(:params) do
      {date: date, category_id: category.id, amount: 0, transaction_id: transaction.id, comment: comment}
    end

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
