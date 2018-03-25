require 'rails_helper'

RSpec.describe CategoryTransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, :category_transactions, user: user) }
  let(:category) { create(:category, user: user) }

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

      it 'creates transaction' do
        expect do
          create(:transaction, :category_transactions, user: user)
        end.to change(CategoryTransaction, :count).by(1)
      end
    end
  end
end
