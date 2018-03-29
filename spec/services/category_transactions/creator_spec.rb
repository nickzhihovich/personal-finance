require 'rails_helper'

RSpec.describe 'CategoryTransactions::Creator', type: :feature do
  context 'when valid' do
    let(:user) { create(:user) }
    let(:balance) { Faker::Number.decimal(4, 2).to_f }
    let(:date) { Faker::Date.between(1.year.ago, Date.current) }
    let(:balance_params) { {date: date, amount: balance, user_id: user.id, comment: nil} }

    let(:category) { create(:category, user: user) }
    let(:amount) { Faker::Number.decimal(3, 2).to_f }
    let(:params) { {amount: amount, user_id: user.id, category_id: category.id} }

    before do
      BalanceTransactions::Creator.new(balance_params).create
    end

    it 'creates CategoryTransaction' do
      expect do
        CategoryTransactions::Creator.new(params).create
      end.to change(CategoryTransaction, :count).by(1)
    end

    it 'creates Transaction' do
      expect do
        CategoryTransactions::Creator.new(params).create
      end.to change(Transaction, :count).by(1)
    end
  end

  context 'when invalid: freebalance < amount' do
    let(:user) { create(:user) }
    let(:amount) { Faker::Number.decimal(3, 2).to_f }
    let(:category) { create(:category, user: user) }
    let(:params) { {amount: amount, user_id: user.id, category_id: category.id} }

    it 'creates Transaction' do
      expect do
        CategoryTransactions::Creator.new(params).create
      end.to change(Transaction, :count).by(0)
    end
  end
end
