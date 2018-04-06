require 'rails_helper'

describe Charts::Home::GetData do
  let(:user) { create(:user) }

  let(:balance) { Faker::Number.decimal(4, 2).to_f }

  let(:category) { create(:category, user: user, categorizable: user) }
  let(:amount) { Faker::Number.decimal(2, 2).to_f }

  let(:categories_titles) { categories.pluck(:title) }

  let(:data) { described_class.new(Transaction.all).call }

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

  it { expect(Transaction.count).to eq(6) }
  it { expect(data.length).to eq(3) }
  it { expect(data[:categories_titles].length).to eq(1) }
  it { expect(data[:categories_amounts].length).to eq(1) }
  it { expect(data[:charts_colors].length).to eq(1) }
end
