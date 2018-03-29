require 'rails_helper'

describe BalanceTransactions::Creator do
  context 'when valid' do
    let(:user) { create(:user) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Internet.slug }
    let(:amount) { Faker::Number.between(100, 1000) }
    let(:params) { {date: date, comment: comment, amount: amount, user_id: user.id} }

    it 'creates BalanceTransaction' do
      expect do
        described_class.new(params).create
      end.to change(BalanceTransaction, :count).by(1)
    end

    it 'creates Transaction' do
      expect do
        described_class.new(params).create
      end.to change(Transaction, :count).by(1)
    end
  end

  context 'when not valid' do
    let(:user) { create(:user) }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:comment) { Faker::Internet.slug }
    let(:params) { {date: date, comment: comment, amount: nil, user_id: user.id} }

    it 'creates Transaction' do
      expect do
        described_class.new(params).create
      end.to change(Transaction, :count).by(0)
    end
  end
end
