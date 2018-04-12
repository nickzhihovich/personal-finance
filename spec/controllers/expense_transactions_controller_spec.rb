require 'rails_helper'

RSpec.describe ExpenseTransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:main_category, user: user, categorizable: user, amount: 10_000) }
  let(:expense_transaction) { create(:expense_transaction, category: category) }
  let(:transaction) do
    create(:expense_transactions, user: user, transactinable: expense_transaction)
  end

  before do
    login_user user
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      let(:attributes) do
        {
          transaction: attributes_for(
            :transaction,
            user: user,
            expense_transactions_attributes: {
              category_id: category.id
            }
          )
        }
      end

      it 'creates transaction' do
        expect do
          post :create, params: attributes
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
          transaction: attributes_for(
            :transaction,
            expense_transactions_attributes: {
              category_id: category.id
            },
            amount: nil
          )
        }
      end

      it 'not creates new transaction' do
        expect do
          post :create, params: attributes
        end.not_to change(Transaction, :count)
      end

      it 'render :new template' do
        post :create, params: attributes
        expect(response).to render_template :new
      end
    end
  end
end
