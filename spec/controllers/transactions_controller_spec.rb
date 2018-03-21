
require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    login_user user
  end

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #search' do
    it 'has a 200 status code' do
      get :search
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE #destroy' do
    context 'when balance transactions' do
      subject(:destroy_transaction) { delete :destroy, params: {id: transaction.id} }

      let!(:transaction) { create(:balance_transactions) }

      it 'destroys the transaction' do
        expect { destroy_transaction }.to change(Transaction, :count).by(-1)
      end

      it 'destroys the balance_transaction' do
        expect { destroy_transaction }.to change(BalanceTransaction, :count).by(-1)
      end
    end

    context 'when category transactions' do
      subject(:destroy_transaction) { delete :destroy, params: {id: transaction.id} }

      let(:category) { create(:main_category, categorizable: user) }
      let(:category_transaction) { create(:category_transaction, category: category) }
      let!(:transaction) { create(:category_transactions, transactinable: category_transaction) }

      before do
        category.update(amount: 1000)
      end

      it 'destroys the transaction' do
        expect { destroy_transaction }.to change(Transaction, :count).by(-1)
      end

      it 'destroys the category_transaction' do
        expect { destroy_transaction }.to change(CategoryTransaction, :count).by(-1)
      end
    end

    context 'when between categories transactions' do
      subject(:destroy_transaction) { delete :destroy, params: {id: transaction.id} }

      let(:category_from) do
        create(:main_category, user: user, categorizable: user)
      end
      let(:category_to) { create(:main_category, user: user, categorizable: user) }
      let(:between_categories_transaction) do
        create(:between_categories_transaction, category_from: category_from, category_to: category_to)
      end

      let!(:transaction) { create(:transaction, transactinable: between_categories_transaction) }

      before do
        category_to.update(amount: 1000)
      end

      it 'destroys the transaction' do
        expect { destroy_transaction }.to change(Transaction, :count).by(-1)
      end

      it 'destroys the between_categories_transaction' do
        expect { destroy_transaction }.to change(BetweenCategoriesTransaction, :count).by(-1)
      end
    end
  end
end
