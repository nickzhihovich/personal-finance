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
      let(:attributes) { attributes_for(:transaction).merge(attributes_for(:balance_transaction)) }

      it 'creates transaction' do
        expect do
          create(:transaction, user: user)
        end.to change(Transaction, :count).by(1)
      end

      it 'redirects after create' do
        post :create, params: {balance_transaction: attributes}
        expect(response).to redirect_to activity_page_path
      end
    end

    context 'when not valid' do
      let(:attributes) { {amount: nil}.merge(attributes_for(:balance_transaction)) }

      it 'not creates new transaction' do
        expect do
          post :create, params: {balance_transaction: attributes}
        end.not_to change(Transaction, :count)
      end

      it 'render :new template' do
        post :create, params: {balance_transaction: attributes}
        expect(response).to redirect_to activity_page_path
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid' do
      let(:user) { create(:user) }
      let(:date) { Faker::Date.between(1.year.ago, Date.current) }
      let(:comment) { Faker::Internet.slug }
      let(:amount) { Faker::Number.between(100, 1000) }
      let(:transaction) { create(:transaction) }

      let(:params) do
        {balance_transaction: {date: date, comment: comment, transaction_id: transaction.id,
                               transactions_attributes: {amount: amount}},
         id: transaction.id}
      end

      before do
        put :update, params: params
        transaction.reload
      end

      it 'updates transaction amount' do
        expect(transaction.amount).to eq(amount)
      end

      it 'updates transaction #transactinable date' do
        expect(transaction.transactinable.date).to eq(date)
      end

      it 'updates transaction #transactinable comment' do
        expect(transaction.transactinable.comment).to eq(comment)
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
          balance_transaction: attributes_for(:transaction,
            amount: nil, date: nil)
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
        put :update, params: {
          id: transaction.id,
          balance_transaction: attributes_for(:transaction, amount: nil, date: nil)
        }
        expect(response).to redirect_to activity_page_path
      end
    end
  end
end
