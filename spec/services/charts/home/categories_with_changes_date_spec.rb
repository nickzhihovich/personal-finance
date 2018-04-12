require 'rails_helper'

describe Charts::Home::CategoriesWithChangesDate do
  let(:user) { create(:user) }

  let(:balance) { Faker::Number.decimal(4, 2).to_f }

  let(:category) { create(:category, user: user, categorizable: user) }
  let(:amount) { Faker::Number.decimal(2, 2).to_f }

  let(:categories_titles) { categories.pluck(:title) }

  let(:changes) do
    Charts::Home::CategoriesWithChanges.new(Transaction.category_transactions).call
  end

  let(:data_chenges) { described_class.new(changes).data }

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

  it { expect(data_chenges.length).to eq(3) }
  it { expect(data_chenges[:categories_titles].length).to eq(1) }
  it { expect(data_chenges[:categories_amounts].length).to eq(1) }
  it { expect(data_chenges[:charts_colors].length).to eq(1) }
  it { expect(data_chenges[:categories_titles][0]).to eq(category.title) }
  it { expect(data_chenges[:categories_amounts][0]).to eq(changes[0][:changes]) }
end
