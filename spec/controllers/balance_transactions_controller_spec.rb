require 'rails_helper'

RSpec.describe BalanceTransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    login_user user
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'renders the :edit template' do
      get :edit, params: {id: transaction.id}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      let(:user) { create(:user) }

      let(:attributes) do
        {
          balance_transaction: attributes_for(:balance_transaction,
            transactions_attributes: attributes_for(:transaction))
        }
      end

      it 'creates transaction' do
        expect do
          create(:transaction, user: user)
        end.to change(Transaction, :count).by(1)
      end

      it 'redirects after create' do
        post :create, params: attributes
        expect(response).to redirect_to activity_page_path
      end
    end

    context 'when not valid' do
      let(:attributes) do
        {
          balance_transaction: attributes_for(:balance_transaction,
            transactions_attributes: attributes_for(:transaction, amount: nil))
        }
      end

      it 'not creates new transaction' do
        expect do
          post :create, params: {balance_transaction: attributes}
        end.not_to change(Transaction, :count)
      end

      it 'render :new template' do
        post :create, params: attributes
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid' do
      let(:amount) { Faker::Number.between(100, 1000) }
      let(:balance_transaction) { create(:transaction) }

      let(:params) do
        {
          id: balance_transaction.id,
          balance_transaction: attributes_for(:balance_transaction,
            transactions_attributes: attributes_for(:transaction, amount: amount,
                                                                  id: balance_transaction.id))
        }
      end

      before do
        put :update, params: params
        balance_transaction.reload
      end

      it 'updates transaction amount' do
        expect(balance_transaction.amount).to eq(amount)
      end

      it 'redirects after update' do
        put :update, params: params
        expect(response).to  redirect_to activity_page_path
      end
    end

    context 'when not valid' do
      let(:init_amount) { transaction.amount }
      let(:init_date) { transaction.date }

      let(:params) do
        {
          id: transaction.id,
          balance_transaction: attributes_for(:balance_transaction,
            transactions_attributes: attributes_for(:transaction,
              amount: nil, data: nil, id: transaction.id))
        }
      end

      before do
        put :update, params: params
        transaction.reload
      end

      it 'transaction not updates when invalid amount' do
        expect(transaction.amount).to eq(init_amount)
      end

      it 'render :edit template' do
        put :update, params: params
        expect(response).to render_template :edit
      end
    end
  end
end
