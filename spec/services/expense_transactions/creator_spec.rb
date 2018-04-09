require 'rails_helper'

describe ExpenseTransactions::Creator do
  let(:user) { create(:user) }
  let(:date) { Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.current) }
  let(:amount) { Faker::Number.decimal(3, 2).to_f }
  let(:comment) { Faker::Internet.slug }

  context 'when valid' do
    let(:balance) { Faker::Number.decimal(4, 2).to_f }
    let(:category) { create(:main_category, amount: balance, user: user) }
    let(:params) do
      {amount: amount, user_id: user.id, category_id: category.id, date: date, comment: comment}
    end

    it 'creates ExpenseTransaction' do
      expect do
        described_class.new(params).create
      end.to change(ExpenseTransaction, :count).by(1)
    end

    it 'creates Transaction' do
      expect do
        described_class.new(params).create
      end.to change(Transaction, :count).by(1)
    end
  end

  context 'when invalid: category.amount < amount' do
    let(:category) { create(:main_category, amount: 100) }
    let(:params) do
      {amount: amount, user_id: user.id, category_id: category.id, date: date, comment: comment}
    end

    it 'creates Transaction' do
      expect do
        described_class.new(params).create
      end.to change(Transaction, :count).by(0)
    end
  end
end
