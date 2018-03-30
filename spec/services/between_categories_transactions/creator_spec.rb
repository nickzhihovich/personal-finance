require 'rails_helper'

describe BetweenCategoriesTransactions::Creator do
  context 'when valid' do
    let(:user) { create(:user) }

    let(:amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }
    let(:amount_from) { BigDecimal.new(10_000) }
    let(:init_category_to_amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }

    let(:category_from) { create(:category, user: user, amount: amount_from) }
    let(:category_to) { create(:category, user: user, amount: init_category_to_amount) }

    let(:params) do
      {amount: amount, user_id: user.id, category_from_id: category_from.id,
       category_to_id: category_to.id}
    end

    it 'creates BetweenCategoriesTransaction' do
      expect do
        described_class.new(params).create
      end.to change(BetweenCategoriesTransaction, :count).by(1)
    end

    it 'creates Transaction' do
      expect do
        described_class.new(params).create
      end.to change(Transaction, :count).by(1)
    end

    context 'when transaction created update balance' do
      before do
        described_class.new(params).create
        category_from.reload
        category_to.reload
      end

      it 'Update category_from amount' do
        expect(category_from.amount).to eq(amount_from - amount)
      end

      it 'Update category_to amount' do
        expect(category_to.amount).to eq(init_category_to_amount + amount)
      end
    end
  end

  context 'when not valid' do
    let(:user) { create(:user) }

    let(:amount) { BigDecimal.new(Faker::Number.decimal(4, 2)) }
    let(:category_amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }

    let(:category_from) { create(:category, user: user, amount: category_amount) }
    let(:category_to) { create(:category, user: user, amount: category_amount) }

    let(:init_category_from_amount) { category_from.amount }
    let(:init_category_to_amount) { category_to.amount }

    let(:params) do
      {amount: amount, user_id: user.id, category_from_id: category_from.id,
       category_to_id: category_to.id}
    end

    before do
      described_class.new(params).create
      category_from.reload
      category_to.reload
    end

    it 'creates BetweenCategoriesTransaction' do
      expect { }.to change(BetweenCategoriesTransaction, :count).by(0)
    end

    it 'creates Transaction' do
      expect { }.to change(Transaction, :count).by(0)
    end

    it 'Update category_from amount' do
      expect(category_from.amount).to eq(init_category_from_amount)
    end

    it 'Update category_to amount' do
      expect(category_to.amount).to eq(init_category_to_amount)
    end
  end
end
