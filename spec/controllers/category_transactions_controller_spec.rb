require 'rails_helper'

RSpec.describe CategoryTransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:main_category) }

  before do
    login_user user
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      visit "/categories/#{category.id}/add_money"
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      let(:user) { create(:user) }
      let(:category) { create(:main_category, categorizable: user) }
      let(:category_transaction) { create(:category_transaction, category: category) }

      it 'creates transaction' do
        expect do
          create(:category_transactions, user: user, transactinable: category_transaction)
        end.to change(CategoryTransaction, :count).by(1)
      end
    end
  end
end
