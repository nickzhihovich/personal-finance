require 'rails_helper'

describe Charts::Home::CategoriesWithChanges do
  let(:user) { create(:user) }

  let(:balance) { Faker::Number.decimal(4, 2).to_f }

  let(:category) { create(:category, user: user, categorizable: user) }
  let(:amount) { Faker::Number.decimal(2, 2).to_f }

  let(:categories_titles) { categories.pluck(:title) }
  let(:expected_amount) { Transaction.category_transactions.sum(&:amount) }

  let(:changes) { described_class.new(Transaction.category_transactions).call }

  before do
    create(:balance_transaction_creator, amount: balance, user: user)

    5.times do
      CategoryTransactions::Creator.new(
        amount: amount,
        user_id: user.id,
        category_id: category.id
      ).create
    end
  end

  it { expect(changes.length).to eq(1) }
  it { expect(changes[0][:category]).to eq(category) }
  it { expect(changes[0][:changes]).to eq(expected_amount) }
end
