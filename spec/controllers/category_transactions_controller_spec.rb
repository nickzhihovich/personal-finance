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

      let(:balance) { Faker::Number.decimal(4, 2).to_f }
      let(:date) { Faker::Date.between(1.year.ago, Date.current) }
      let(:balance_params) { {date: date, amount: balance, user_id: user.id, comment: nil} }

      let(:category) { create(:main_category, categorizable: user) }
      let(:amount) { Faker::Number.decimal(3, 2).to_f }

      let(:params) do
        {
          id: category.id,
          category_transaction: {
            amount: amount
          }
        }
      end

      before do
        BalanceTransactions::Creator.new(balance_params).create
      end

      it 'creates transaction' do
        expect do
          post :create, params: params
        end.to change(CategoryTransaction, :count).by(1)
      end
    end
  end
end
